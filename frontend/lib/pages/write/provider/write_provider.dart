import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/write/model/prompt_info.dart';
import 'package:frontend/pages/write/repository/write_repository.dart';
import 'package:frontend/utils/sp_provider.dart';
import 'package:logger/logger.dart';

/// 切换工作空间 提示词-生成文本[change workspace state]
final writeWorkspaceProvider = StateProvider.autoDispose<int>((ref) => 0);

/// 选择提示词[choose prompt template model]
final promptInfoProvider =
    StateProvider.autoDispose<PromptInfo>((ref) => getDefaultPromptInfo());

/// 清空提示词模版[clear prompt template model]
final clearPromptInfoProvider =
    StateProvider.autoDispose<PromptInfo>((ref) => getDefaultPromptInfo());

/// 开始生成[start generate content]
final startGenerateProvider =
    StateProvider.autoDispose<Map<String, dynamic>>((ref) => {});

/// 开始生成-设置是否显示复制按钮[show copy button state]
final showCopyProvider = StateProvider.autoDispose<bool>((ref) => false);

///
/// writeStateProvider
///
final writeStateProvider =
    StateNotifierProvider.autoDispose<WriteNotifier, WriteState>(
        (ref) => WriteNotifier());

///
/// Default prompt info
///
PromptInfo getDefaultPromptInfo() {
  return PromptInfo(
      title: t.write.prompt_title,
      content: '',
      label: '',
      topic: t.write.prompt_topic,
      prompt: t.write.prompt_tip,
      system: t.write.prompt_system);
}

class WriteState {
  int code;
  String msg;

  WriteState({this.code = -1, this.msg = ''});
}

class WriteNotifier extends StateNotifier<WriteState> {
  WriteNotifier() : super(WriteState());

  ///
  /// Directly request openai api
  ///
  Stream<String> sendMessageStream(String system, String prompt) async* {
    String showContent = "";
    state = WriteState(code: 0, msg: t.write.generate_loading);
    try {
      final stream =
          await WriteRepository.instance.sendMessageStream(system, prompt);
      await for (final chunk in stream) {
        debugPrint("received stream = $chunk");
        final dataLines =
            chunk.split("\n").where((element) => element.isNotEmpty).toList();
        Logger().d("dataLines ---- $dataLines");
        for (final line in dataLines) {
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6);
          Logger().d("substring map ---- $data");
          if (data == "[DONE]") {
            Logger().d('data received complete，data.[DONE]');
            break;
          }
          Map<String, dynamic> responseData = json.decode(data);
          Logger().d("Response ---- $responseData");
          List<dynamic> choices = responseData["choices"];
          Map<String, dynamic> choice = choices[0];
          Map<String, dynamic> delta = choice["delta"];
          String content = delta["content"] ?? "";
          showContent += content;
          Logger().d("content ---- $showContent");
          yield showContent;
          String finishReason = choice["finish_reason"] ?? "";
          if (finishReason.isNotEmpty) {
            Logger().d("finish_reason：$finishReason");
            break;
          }
          await Future.delayed(const Duration(milliseconds: 16));
        }
      }
    } catch (e) {
      yield showContent.isEmpty ? t.app.error : showContent;
      Logger().d('stream received error $e');
    } finally {
      state = WriteState(
          code: 1,
          msg: showContent.isEmpty ? t.app.error : t.write.generate_finished);
      yield showContent.isEmpty ? t.app.error : showContent;
      SpProvider().setString('generate_content', showContent);
      Logger().d('stream receive finished，$showContent');
    }
  }

  ///
  /// Python API
  ///
  Stream<String> sendMessageStreamApi(String system, String prompt) async* {
    state = WriteState(code: 0, msg: t.write.generate_loading);
    String showContent = "";
    try {
      debugPrint("start stream = ${DateTime.now()}");
      final stream =
          await WriteRepository.instance.sendMessageStreamApi(system, prompt);
      debugPrint("end stream = ${DateTime.now()}");
      await for (final chunk in stream) {
        debugPrint("received stream =$chunk");
        final dataLines =
            chunk.split("\n").where((element) => element.isNotEmpty).toList();
        for (final line in dataLines) {
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6).isEmpty ? "\n" : line.substring(6);
          if (showContent.endsWith('\n') && data == '\n') continue;
          showContent += data;
          yield showContent;
          await Future.delayed(const Duration(milliseconds: 16));
        }
      }
    } catch (e) {
      yield showContent.isEmpty ? t.app.error : showContent;
      Logger().d('stream received error $e');
    }
    state = WriteState(
        code: 1,
        msg: showContent.isEmpty ? t.app.error : t.write.generate_finished);
    yield showContent.isEmpty ? t.app.error : showContent;
    SpProvider().setString('generate_content', showContent);
    Logger().d('stream receive finished，$showContent');
  }
}

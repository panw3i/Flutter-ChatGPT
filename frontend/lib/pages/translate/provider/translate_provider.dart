import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/model/translate_model.dart';
import 'package:frontend/pages/translate/repository/translate_repository.dart';
import 'package:frontend/utils/sp_provider.dart';
import 'package:logger/logger.dart';

/// 更新语言列表选中[update language selected]
final updateLanguageProvider = StateProvider.autoDispose<double>((ref) => 0);

/// 点击[开始翻译],同步待翻译内容[start translate action]
final translateInputProvider = StateProvider.autoDispose<Map<bool, String>>(
    (ref) => {false: t.translate.translate_tip});

/// 显示翻译进度条[translate generate content loading]
final showGenerateProvider = StateProvider.autoDispose<bool>((ref) => false);

///
/// translateStateProvider
///
final translateStateProvider =
    StateNotifierProvider.autoDispose<TranslateNotifier, TranslateState>(
        (ref) => TranslateNotifier());

class TranslateState {
  String? outputContent;
  bool? isLoading;

  TranslateState({this.outputContent, this.isLoading = false});
}

class TranslateNotifier extends StateNotifier<TranslateState> {
  TranslateNotifier() : super(TranslateState());

  ///
  /// 直接请求OpenAI API
  ///
  void translateInput(
      String inputStr, String inputType, String targetType) async {
    state = TranslateState(isLoading: true);
    try {
      final response = await TranslateRepository.instance
          .translateInput(inputStr, inputType, targetType);
      Logger()
          .d('response:${response.body}, statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        final translateModel = TranslateModel.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        var msg = '';
        translateModel.choices?.forEach((element) {
          if (element.message?.content?.isNotEmpty ?? false) {
            msg += element.message!.content!;
          }
        });
        state = TranslateState(outputContent: msg, isLoading: false);
        return;
      }
      state = TranslateState(
          outputContent: state.outputContent ?? '', isLoading: false);
    } catch (e) {
      state = TranslateState(
          outputContent: state.outputContent ?? '', isLoading: false);
    }
  }

  ///
  /// Python API
  ///
  Stream<String> sendMessageStreamApi(
      String message, Function waiting, Function finish) async* {
    waiting();
    String showContent = "";
    try {
      debugPrint("start stream = ${DateTime.now()}");
      final stream =
          await TranslateRepository.instance.sendMessageStreamApi(message);
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
      yield showContent.isEmpty ? t.translate.translate_failure : showContent;
      debugPrint('stream received error $e');
    }
    yield showContent;
    finish();
    SpProvider().setString('translate', showContent);
  }
}

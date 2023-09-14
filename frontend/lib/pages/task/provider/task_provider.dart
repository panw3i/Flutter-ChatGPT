import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/task/model/task_message.dart';
import 'package:frontend/pages/task/repository/task_repository.dart';
import 'package:frontend/utils/sp_provider.dart';
import 'package:logger/logger.dart';

/// 是否允许输入[task text field allow input]
final allowInputTaskProvider = StateProvider.autoDispose<bool>((ref) => true);

/// 输入问题-发送信息[task message send state action]
final sendMessageTaskProvider = StateProvider.autoDispose<double>((ref) => 0);

///
/// taskStateProvider
///
final taskStateProvider =
    StateNotifierProvider.autoDispose<TaskNotifier, TaskState>(
        (ref) => TaskNotifier());

class TaskState {
  int code;
  String msg;
  List<TaskMessages>? data;

  TaskState({this.code = -1, this.msg = '', this.data});
}

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(TaskState());

  final taskMessage = <TaskMessages>[];

  Future addMessages(String msg, {bool isUser = true}) {
    taskMessage.add(TaskMessages(
        isUser: isUser, message: msg, time: DateTime.now().toString()));
    Logger().d(taskMessage);
    return Future.value(1);
  }

  void queryMessage() {
    Logger().d(taskMessage);
    state = TaskState(code: state.code, msg: state.msg, data: taskMessage);
  }

  void clearMessage() {
    taskMessage.clear();
  }

  ///
  /// Test stream returning
  ///
  Stream<String> getTextStream(
      String topic, String content, Function waiting, Function finish) async* {
    String showContent = '';
    final text = t.app.big_text;
    waiting();
    await Future.delayed(const Duration(milliseconds: 5000));
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 16));
      yield showContent += text.substring(i, i + 1);
    }
    addMessages(showContent, isUser: false).then((value) => queryMessage());
    SpProvider().setString('generate_content', showContent);
    finish();
  }

  ///
  /// Directly request openai api
  ///
  Stream<String> sendMessageStream(
      String topic, String content, Function waiting, Function finish) async* {
    if (taskMessage.isEmpty) return;
    final inputStr = taskMessage.last.message ?? '';
    if (inputStr.isEmpty) return;
    String showContent = "";
    waiting();
    try {
      final stream =
          await TaskRepository.instance.sendMessageStreamTask(inputStr);
      await for (final chunk in stream) {
        debugPrint("received stream = $chunk");
        final dataLines =
            chunk.split("\n").where((element) => element.isNotEmpty).toList();
        Logger().d("dataLines ---- $dataLines");
        for (final line in dataLines) {
          if (line.startsWith('error')) {
            yield showContent += line.substring(7);
            break;
          }
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6);
          Logger().d("line.substring ---- $data");
          if (data == "[DONE]") {
            Logger().d('data receive finished，data.[DONE]');
            break;
          }
          Map<String, dynamic> responseData = json.decode(data);
          Logger().d("Response ---- $responseData");
          List<dynamic> choices = responseData["choices"];
          Map<String, dynamic> choice = choices[0];
          Map<String, dynamic> delta = choice["delta"];
          String content = delta["content"] ?? "";
          showContent += content;
          Logger().d("showContent ---- $showContent");
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
      finish();
      yield showContent.isEmpty ? t.app.error : showContent;
      addMessages(showContent.isEmpty ? t.app.error : showContent,
          isUser: false);
      queryMessage();
      SpProvider().setString('generate_content', showContent);
      Logger().d('stream receive finished，$showContent');
    }
  }

  ///
  /// Python-API Stream<String>
  ///
  Stream<String> sendMessageStreamApi(
      String topic, String content, Function waiting, Function finish) async* {
    if (taskMessage.isEmpty) return;
    final inputStr = taskMessage.last.message ?? '';
    if (inputStr.isEmpty) return;
    String showContent = "";
    waiting();
    try {
      debugPrint("start stream = ${DateTime.now()}");
      final stream =
          await TaskRepository.instance.sendMessageStreamApi(inputStr);
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
    finish();
    yield showContent.isEmpty ? t.app.error : showContent;
    addMessages(showContent.isEmpty ? t.app.error : showContent, isUser: false);
    queryMessage();
    SpProvider().setString('generate_content', showContent);
    Logger().d('stream receive finished，$showContent');
  }
}

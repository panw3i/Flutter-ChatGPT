import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';
import 'package:frontend/pages/task/provider/task_provider.dart';
import 'package:frontend/widget/message_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 聊天输入框[Task message text field]
///
class TaskInput extends ConsumerWidget {
  TaskInput({super.key});

  late final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowInput = ref.watch(allowInputProvider);
    return MessageTextField(
        controller, allowInput, (str) => handleInputStr(str, ref));
  }

  ///处理输入框内容
  void handleInputStr(String inputStr, WidgetRef ref) async {
    final sendInputStr = inputStr.trim();
    if (sendInputStr.isEmpty) return;
    //发送用户聊天消息
    await ref.read(taskStateProvider.notifier).addMessages(inputStr);
    //查询聊天记录
    ref.read(taskStateProvider.notifier).queryMessage();
    //通知请求ChatGPT接口
    ref
        .read(sendMessageTaskProvider.notifier)
        .update((state) => state = Random().nextDouble());
  }
}

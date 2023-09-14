import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';
import 'package:frontend/widget/message_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 聊天输入框[chat text field]
///
class ChatInput extends ConsumerWidget {
  ChatInput({super.key});

  late final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(chatSelectedProvider);
    final allowInput = ref.watch(allowInputProvider);
    return Visibility(
        visible: selected.conversationId != null,
        child: MessageTextField(controller, allowInput,
            (str) => handleInputStr(str, selected.conversationId, ref)));
  }

  /// 处理输入框内容[handle input str]
  void handleInputStr(String inputStr, num? selectedId, WidgetRef ref) async {
    final sendInputStr = inputStr.trim();
    if (sendInputStr.isEmpty) return;
    //发送用户聊天消息
    await ref
        .read(conversationProvider.notifier)
        .addMessages(selectedId, inputStr, true);
    //查询聊天记录
    await ref
        .read(conversationProvider.notifier)
        .queryMessagesWithId(selectedId);
    //通知请求ChatGPT接口
    ref
        .read(sendMessageProvider.notifier)
        .update((state) => state = Random().nextDouble());
  }
}

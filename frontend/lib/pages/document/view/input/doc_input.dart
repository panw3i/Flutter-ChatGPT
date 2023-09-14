import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/document/provider/doc_provider.dart';
import 'package:frontend/widget/message_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 文档对话输入框[doc conversation text field]
///
class DocInput extends ConsumerWidget {
  DocInput({super.key});

  late final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(chatSelectedDocProvider);
    final allowInput = ref.watch(allowInputDocProvider);
    return Visibility(
        visible: selected.conversationId != null,
        child: MessageTextField(controller, allowInput,
            (str) => handleInputStr(str, selected.conversationId, ref),
            maxWidth: 680));
  }

  /// 处理输入框内容[handle input str]
  void handleInputStr(String inputStr, num? selectedId, WidgetRef ref) async {
    final sendInputStr = inputStr.trim();
    if (sendInputStr.isEmpty) return;
    //发送用户聊天消息
    await ref
        .read(conversationDocProvider.notifier)
        .addMessages(selectedId, inputStr, true);
    //查询聊天记录
    await ref
        .read(conversationDocProvider.notifier)
        .queryMessagesWithId(selectedId);
    ref
        .read(sendMessageDocProvider.notifier)
        .update((state) => Random().nextDouble());
  }
}

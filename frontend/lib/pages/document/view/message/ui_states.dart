import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/document/model/doc_selected.dart';
import 'package:frontend/pages/document/provider/doc_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 监听文档消息
///
List<Messages>? watchDocMessages(WidgetRef ref) =>
    ref.watch(conversationDocProvider).messages;

///
/// 监听初始文档消息列表滚动
///
listenDocMessagesScroll(WidgetRef ref, VoidCallback scrollEnd) {
  ref.listen(conversationDocProvider, (_, next) {
    if (next.messages == null || next.messages!.isEmpty) return;
    Future.delayed(const Duration(milliseconds: 100), () => scrollEnd());
  });
}

///
/// 输入框发送消息事件
///
listenDocMessageSend(WidgetRef ref, List<double> sendList) {
  ref.listen(sendMessageDocProvider, (previous, next) {
    sendList.add(next);
  });
}

///
/// 监听文档对话切换
///
DocSelected watchDocConversationSelected(WidgetRef ref) =>
    ref.watch(chatSelectedDocProvider);

listenDocConversationSelected(WidgetRef ref) {
  ref.listen(chatSelectedDocProvider, (previous, next) {
    ref
        .read(conversationDocProvider.notifier)
        .queryMessagesWithId(next.conversationId);
  });
}

///
/// 流式请求
///
Stream<String>? stream(WidgetRef ref, bool mounted, num? selectedId,
    List<Messages>? messages, String? title) {
  return ref
      .read(conversationDocProvider.notifier)
      .sendMessageStream(selectedId, messages, title ?? '', () {
    if (!mounted) return;
    ref.read(allowInputDocProvider.notifier).update((state) => false);
  }, () {
    if (!mounted) return;
    ref.read(allowInputDocProvider.notifier).update((state) => true);
  });
}

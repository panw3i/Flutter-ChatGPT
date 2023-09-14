import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 对话消息列表
///
List<Messages>? watchMessageList(WidgetRef ref) =>
    ref.watch(conversationProvider).messages;

///
/// 输入框发送消息事件
///
listenSendMessage(WidgetRef ref, List<double> sendList) {
  ref.listen(sendMessageProvider, (previous, next) {
    sendList.add(next);
  });
}

///
/// 监听对话,滚动消息
///
listenConversationScroll(WidgetRef ref, VoidCallback scrollEnd) {
  ref.listen(conversationProvider, (_, next) {
    if (next.messages == null || next.messages!.isEmpty) return;
    Future.delayed(const Duration(milliseconds: 100), () => scrollEnd());
  });
}

///
/// 监听对话切换，当切换时再次刷新message
///
watchConversationSelected(WidgetRef ref) =>
    ref.watch(chatSelectedProvider).conversationId;

///
/// 监听对话切换,当切换时再次刷新message
///
listenConversationSelected(WidgetRef ref) {
  ref.listen(chatSelectedProvider, (previous, next) {
    ref
        .read(conversationProvider.notifier)
        .queryMessagesWithId(next.conversationId);
  });
}

///
/// 流式请求
///
Stream<String>? stream(
    WidgetRef ref, bool mounted, num? selectedId, List<Messages>? messages) {
  return ref
      .read(conversationProvider.notifier)
      // .sendMessageStream(widget.selectedId, widget.msgList, () {
      .sendMessageStreamApi(selectedId, messages, () {
    if (!mounted) return;
    ref.read(allowInputProvider.notifier).update((state) => false);
  }, () {
    if (!mounted) return;
    ref.read(allowInputProvider.notifier).update((state) => true);
  });
}

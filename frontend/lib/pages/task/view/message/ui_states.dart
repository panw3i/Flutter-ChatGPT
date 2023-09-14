import 'package:flutter/material.dart';
import 'package:frontend/pages/task/model/task_message.dart';
import 'package:frontend/pages/task/provider/task_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 对话消息列表[task message list]
///
List<TaskMessages>? watchMessageList(WidgetRef ref) =>
    ref.watch(taskStateProvider).data;

///
/// 输入框发送消息事件[listen send message state]
///
listenSendMessage(WidgetRef ref, List<double> sendList) {
  ref.listen(sendMessageTaskProvider, (previous, next) {
    sendList.add(next);
  });
}

///
/// 监听对话,滚动消息[listen conversation scroll]
///
listenConversationScroll(WidgetRef ref, VoidCallback scrollEnd) {
  ref.listen(taskStateProvider, (_, next) {
    if (next.data == null || next.data!.isEmpty) return;
    Future.delayed(const Duration(milliseconds: 100), () => scrollEnd());
  });
}

///
/// 流式请求[request task stream message]
///
Stream<String>? stream(WidgetRef ref, bool mounted) {
  return
      //ref.read(taskStateProvider.notifier).sendMessageStream('', '', () {
      ref.read(taskStateProvider.notifier).sendMessageStreamApi('', '', () {
    if (!mounted) return;
    ref.read(allowInputTaskProvider.notifier).update((state) => false);
  }, () {
    if (!mounted) return;
    ref.read(allowInputTaskProvider.notifier).update((state) => true);
  });
}

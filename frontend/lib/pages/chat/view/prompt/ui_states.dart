import 'dart:math';

import 'package:frontend/pages/chat/model/chat_selected.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 预设prompt模版 - 新增对话
///
addConversation(WidgetRef ref, String promptTitle, String promptContent,
    Function start, Function finish) async {
  start();
  //新增对话
  final key = await ref
      .read(conversationProvider.notifier)
      .addConversationPrompt(promptTitle);
  //新增机器人默认消息
  //await ref.read(conversationProvider.notifier).addDefaultMessages(key);
  //新增prompt消息
  await ref
      .read(conversationProvider.notifier)
      .addMessages(key, promptContent, true);
  //通知对话选中项
  ref
      .read(chatSelectedProvider.notifier)
      .update((state) => ChatSelected(conversationId: key));
  //查询聊天记录
  // await ref.read(conversationProvider.notifier).queryMessagesWithId(key);
  //模拟输入框消息发出
  ref
      .read(sendMessageProvider.notifier)
      .update((state) => Random().nextDouble());
  finish();
}

///
/// watch新增对话状态
///
bool watchProgress(WidgetRef ref) => ref.watch(showProgressProvider);

///
/// 更新新增对话状态
///
updateProgress(WidgetRef ref, bool showLoading) {
  ref.read(showProgressProvider.notifier).update((state) => showLoading);
}

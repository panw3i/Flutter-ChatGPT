import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/chat/model/chat_selected.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 监听对话列表[listen conversation list]
///
listenConversationList(WidgetRef ref, bool defaultSelected) {
  ref.listen(conversationProvider, (previous, next) {
    //默认不选中，显示引导页面
    if (defaultSelected) {
      defaultSelected = false;
      final list = next.conversations;
      if (list == null || list.isEmpty) {
        ref
            .read(chatSelectedProvider.notifier)
            .update((state) => ChatSelected(isDefault: true));
        return;
      }
      //选中对话时刷新对应message
      final id = list[0].id;
      ref
          .read(chatSelectedProvider.notifier)
          .update((state) => ChatSelected(conversationId: id, isDefault: true));
    }
  });
}

///
/// 观察对话列表[listen conversation list]
///
watchConversationList(WidgetRef ref) =>
    ref.watch(conversationProvider).conversations;

///
/// 监听对话切换[listen conversation selected]
///
listenConversationSelected(WidgetRef ref) {
  ref.listen(chatSelectedProvider, (previous, next) {
    //切换时再次刷新列表,如果isDefault=true,表示默认选中
    if (next.isDefault) return;
    ref.read(conversationProvider.notifier).queryConversationList();
  });
}

///
/// 观察对话切换[listen conversation selected]
///
watchConversationSelected(WidgetRef ref) => ref.watch(chatSelectedProvider);

///
/// 点击对话列表并选中[onTap conversation listener]
///
onTapConversation(ChatSelected chatSelected, WidgetRef ref) {
  //通知输入框开启输入
  ref.read(allowInputProvider.notifier).update((state) => true);
  //选中对话，同时查询对话消息
  ref.read(chatSelectedProvider.notifier).update((state) => chatSelected);
}

///
/// 新增对话[add conversation]
///
addConversation(WidgetRef ref) async {
  //新增
  final key = await ref.read(conversationProvider.notifier).addConversation();
  final selected = ChatSelected(conversationId: key);
  ref.read(chatSelectedProvider.notifier).update((state) => state = selected);
}

///
/// 编辑对话主题名称[edit conversation title]
///
editConversation(Conversations conversations, WidgetRef ref, String text) {
  ref
      .read(conversationProvider.notifier)
      .updateConversationTitle(conversations.id, text)
      .then((value) =>
          ref.read(conversationProvider.notifier).queryConversationList());
}

///
/// 删除对话[delete conversation]
///
deleteConversation(
  Conversations conversations,
  bool currentSelect,
  WidgetRef ref,
  bool defaultSelected,
) async {
  await ref
      .read(conversationProvider.notifier)
      .deleteConversations(conversations.id);
  if (currentSelect) {
    defaultSelected = true;
  }
  ref.read(conversationProvider.notifier).queryConversationList();
}

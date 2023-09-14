import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/document/model/doc_selected.dart';
import 'package:frontend/pages/document/provider/doc_provider.dart';
import 'package:frontend/widget/show_snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

///
/// 获取backend文档列表、frontend文档列表，frontend列表缺失时新增
/// query backend/frontend file list, add to frontend list if missing
///
checkDefaultConversationMessage(WidgetRef ref) async {
  //查询系统文档列表
  final fileNameList =
      await ref.read(conversationDocProvider.notifier).getVectorFileList();
  //查询对话列表
  final conversationList = await ref
      .read(conversationDocProvider.notifier)
      .queryConversationListSelected();
  final titleList = conversationList.map((e) => e.title).toList();
  //比较本地对话与系统文件列表
  List<String> titles =
      fileNameList.where((title) => !titleList.contains(title)).toList();
  if (titles.isEmpty) {
    //没有新增系统文件,刷新对话列表
    ref.read(conversationDocProvider.notifier).queryConversationList();
    return;
  }
  //新增系统文件对话
  for (final title in titles) {
    final key = await ref
        .read(conversationDocProvider.notifier)
        .addConversationName(title);
    await ref.read(conversationDocProvider.notifier).addDefaultMessages(key);
  }
  //刷新对话列表
  ref.read(conversationDocProvider.notifier).queryConversationList();
}

///
/// 监听文档列表[listen doc conversation ConversationState]
///
ConversationState watchDocConversation(WidgetRef ref) =>
    ref.watch(conversationDocProvider);

listenerDocConversation(WidgetRef ref) {
  ref.listen(conversationDocProvider, (previous, next) {
    switch (next.status) {
      case 0:
      case 1:
      case 2:
        showSnackBar(next.tips);
        break;
    }
  });
}

///
/// 监听对话切换[listen doc conversation selected]
///
DocSelected watchDocChatSelected(WidgetRef ref) =>
    ref.watch(chatSelectedDocProvider);

listenDocChatSelected(WidgetRef ref) {
  ref.listen(chatSelectedDocProvider, (previous, next) {
    //查询所有对话列表
    ref.read(conversationDocProvider.notifier).queryConversationList();
  });
}

///
/// 新增文档对话[add doc conversation]
///
addDocConversation(List<Conversations>? docList, WidgetRef ref) async {
  String name = await ref.read(conversationDocProvider.notifier).uploadFile();
  //文件上传成功，开始创建会话
  if (name.isNotEmpty) {
    //查询系统文档列表
    final fileNameList =
        await ref.read(conversationDocProvider.notifier).getVectorFileList();
    if (docList == null || docList.isEmpty) {
      Logger().d('Vector doc conversation is empty');
      return;
    }
    final titleList = docList.map((e) => e.title).toList();
    //比较本地对话与系统文件列表
    List<String> titles =
        fileNameList.where((title) => !titleList.contains(title)).toList();
    if (titles.isEmpty) {
      //没有新增系统文件,刷新对话列表
      showSnackBar('文件索引为空,请重新上传');
      return;
    }
    //新增系统文件对话
    for (final title in titles) {
      final key = await ref
          .read(conversationDocProvider.notifier)
          .addConversationName(title);
      await ref.read(conversationDocProvider.notifier).addDefaultMessages(key);
    }
    //刷新对话列表
    ref.read(conversationDocProvider.notifier).queryConversationList();
  }
}

///
/// 点击文档对话列表并选中[doc conversation selected]
///
onTapDocConversation(int index, Conversations conversation, WidgetRef ref) {
  //通知输入框开启输入
  ref.read(allowInputDocProvider.notifier).update((state) => true);
  //选中对话，同时查询对话消息
  final selected = DocSelected(
      index: index,
      conversationTitle: conversation.title,
      conversationId: conversation.id);
  ref.read(chatSelectedDocProvider.notifier).update((state) => selected);
}

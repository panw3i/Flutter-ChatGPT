import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/view/message/ui_states.dart';
import 'package:frontend/pages/message/message_bot.dart';
import 'package:frontend/pages/message/message_user.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/widget/message_default_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 聊天消息列表[chat message list view]
///
class ChatMessage extends ConsumerStatefulWidget {
  const ChatMessage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatMessageState();
  }
}

///聊天消息
class ChatMessageState extends ConsumerState<ChatMessage> {
  final ScrollController controller = ScrollController();

  //输入框发送消息
  final sendList = <double>[];

  @override
  Widget build(BuildContext context) {
    //对话消息
    final messages = watchMessageList(ref);
    //输入框发送消息事件
    listenSendMessage(ref, sendList);
    //监听对话,滚动消息
    listenConversationScroll(ref, () => scrollEnd(controller, 400));
    //监听对话切换，当切换时再次刷新message
    final selectedId = watchConversationSelected(ref);
    listenConversationSelected(ref);
    return (messages?.length ?? 0) == 0
        ? const MessageDefaultView()
        : ListView.separated(
            controller: controller,
            shrinkWrap: true,
            itemCount: (messages?.length ?? 0) + sendList.length,
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            itemBuilder: (_, index) {
              final list = messages!;
              if (index >= list.length) {
                //满足构建ChatGPT聊天view时，清空消息发送操作
                sendList.clear();
                return MessageBotView(
                    stream(ref, mounted, selectedId, messages),
                    '',
                    '',
                    true,
                    controller);
              }
              final chatMessage = list[index];
              final displayMsg = chatMessage.message ?? '';
              final displayTime = chatMessage.time ?? '';

              return chatMessage.isUser == true
                  ? MessageUserView(displayMsg, displayTime)
                  : MessageBotView(stream(ref, mounted, selectedId, messages),
                      displayMsg, displayTime, false, controller);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 24));
  }
}

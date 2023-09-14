
import 'package:flutter/material.dart';
import 'package:frontend/pages/document/view/message/ui_states.dart';
import 'package:frontend/pages/message/message_bot.dart';
import 'package:frontend/pages/message/message_user.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/widget/message_default_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 本地知识问答聊天消息
/// [Local Doc Q&A]
///
class DocMessage extends ConsumerStatefulWidget {
  const DocMessage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DocMessageState();
  }
}

class DocMessageState extends ConsumerState<DocMessage> {
  final ScrollController controller = ScrollController();

  //输入框发送消息
  final sendList = <double>[];

  @override
  Widget build(BuildContext context) {
    //对话消息
    final messages = watchDocMessages(ref);
    //输入框发送消息事件
    listenDocMessageSend(ref, sendList);
    //监听对话,滚动消息
    listenDocMessagesScroll(ref, () => scrollEnd(controller, 400));
    //监听对话切换，当切换时再次刷新message
    final selected = watchDocConversationSelected(ref);
    listenDocConversationSelected(ref);
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
                sendList.clear();
                return MessageBotView(
                    stream(ref, mounted, selected.conversationId, messages,
                        selected.conversationTitle),
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
                  : MessageBotView(
                      stream(ref, mounted, selected.conversationId, messages,
                          selected.conversationTitle),
                      displayMsg,
                      displayTime,
                      false,
                      controller);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 24));
  }
}

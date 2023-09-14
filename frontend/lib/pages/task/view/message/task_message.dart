import 'package:flutter/material.dart';
import 'package:frontend/pages/message/message_bot.dart';
import 'package:frontend/pages/message/message_user.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/pages/task/view/message/ui_states.dart';
import 'package:frontend/widget/message_default_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// Bot and User Message
///
class TaskMessage extends ConsumerStatefulWidget {
  const TaskMessage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TaskMessageState();
  }
}

///聊天消息
class TaskMessageState extends ConsumerState<TaskMessage> {
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
                    stream(ref, mounted), '', '', true, controller);
              }
              final chatMessage = list[index];
              final displayMsg = chatMessage.message ?? '';
              final displayTime = chatMessage.time ?? '';

              return chatMessage.isUser == true
                  ? MessageUserView(displayMsg, displayTime)
                  : MessageBotView(stream(ref, mounted), displayMsg,
                      displayTime, false, controller);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 24));
  }
}

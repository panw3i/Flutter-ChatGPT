import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/chat/view/conversation/ui_states.dart';
import 'package:frontend/pages/chat/view/conversation/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 对话列表
/// [conversation list]
///
class ChatConversation extends ConsumerStatefulWidget {
  const ChatConversation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatConversationState();
  }
}

class ChatConversationState extends ConsumerState<ChatConversation> {
  //是否默认选中标记
  var defaultSelected = false;

  @override
  Widget build(BuildContext context) {
    //监听对话
    final conversations = watchConversationList(ref);
    listenConversationList(ref, defaultSelected);
    //监听对话切换
    final selected = watchConversationSelected(ref);
    listenConversationSelected(ref);
    return Container(
        width: 256,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(bottom: 24, top: 16),
        color: Theme.of(context).navigationDrawerTheme.surfaceTintColor,
        child: Column(children: [
          SizedBox(
              height: 48,
              width: double.infinity,
              child: createFloatingActionButton(() => addConversation(ref))),
          const SizedBox(height: 8),
          Expanded(
              child: createConversationList(
                  conversations,
                  selected,
                  (p0) => onTapConversation(p0, ref),
                  (p0) => showEditDialog(p0),
                  (p0, p1) => deleteConversation(p0, p1, ref, defaultSelected)))
        ]));
  }

  showEditDialog(Conversations conversations) {
    final controller = TextEditingController(text: conversations.title ?? '');
    showDialog(
        context: context,
        builder: (context) {
          return createAlertDialog(context, controller, (text) {
            editConversation(conversations, ref, text);
          });
        });
  }
}

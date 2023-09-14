import 'package:flutter/material.dart';
import 'package:frontend/pages/document/view/conversation/doc_list.dart';
import 'package:frontend/pages/document/view/conversation/doc_upload.dart';
import 'package:frontend/pages/document/view/conversation/ui_states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 本地文档问答对话列表
/// [doc conversation list]
///
class DocConversation extends ConsumerStatefulWidget {
  const DocConversation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DocConversationState();
  }
}

class DocConversationState extends ConsumerState<DocConversation> {
  @override
  void initState() {
    super.initState();
    checkDefaultConversationMessage(ref);
  }

  @override
  Widget build(BuildContext context) {
    //监听对话
    final conversationDoc = watchDocConversation(ref);
    //监听对话切换
    listenerDocConversation(ref);
    return Container(
        width: 256,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(bottom: 24, top: 16),
        color: Theme.of(context).navigationDrawerTheme.surfaceTintColor,
        child: Column(children: [
          DocUpload(conversationDoc.conversations, conversationDoc.status),
          const SizedBox(height: 8),
          Expanded(child: DocConversationList(conversationDoc.conversations))
        ]));
  }
}

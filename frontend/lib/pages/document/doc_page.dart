import 'package:flutter/material.dart';
import 'package:frontend/pages/document/view/input/doc_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/document/view/conversation/doc_conversation.dart';
import 'package:frontend/pages/document/view/message/doc_message.dart';
import 'package:frontend/pages/document/view/message/doc_message_clean.dart';
import 'package:frontend/pages/document/view/setting/doc_setting.dart';

///
/// 智能文档[AI-Document]
///
class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DocumentPageState();
  }
}

class DocumentPageState extends ConsumerState<DocumentPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //左侧聊天频道列表[doc conversation]
              const DocConversation(),
              //中间聊天窗口[doc conversation messages]
              createMessage(),
              //右侧设置[doc setting]
              const DocSetting()
            ])
          ])),
    );
  }

  ///
  /// 中间聊天窗口[message list view]
  ///
  Widget createMessage() {
    final surfaceVariant = Theme.of(context).colorScheme.surfaceVariant;
    final background = Theme.of(context).colorScheme.background;
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 16, bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: surfaceVariant, width: 1)),
      child: Column(children: [
        Expanded(
            child: Container(
                alignment: Alignment.topCenter,
                color: background,
                constraints: const BoxConstraints(minWidth: 360, maxWidth: 752),
                child: const DocMessage())),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              const DocMessageClean(),
              // DocTextField()
              DocInput(),
            ])),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

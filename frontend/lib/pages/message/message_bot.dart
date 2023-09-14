import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/widget/message_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// AI-Bot chat message widget
///
class MessageBotView extends StatelessWidget {
  const MessageBotView(this.stream, this.displayMsg, this.displayTime,
      this.isUserSend, this.controller,
      {super.key});

  final Stream<String>? stream;

  //当前显示消息
  final String displayMsg;

  final String displayTime;

  //是否用户发出消息
  final bool isUserSend;

  //滚动控制
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(top: 32), child: createBotAvatar()),
      const SizedBox(width: 16.0),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        displayMsg.isEmpty
            ? const Text('')
            : Row(
                children: [
                  createTimeText(context, checkTimeStr(displayTime)),
                  const SizedBox(width: 4),
                  createCopyTextButton(displayMsg),
                ],
              ),
        const SizedBox(height: 4),
        Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                // color: Theme.of(context).colorScheme.tertiaryContainer,
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2))
                ]),
            child: isUserSend
                ? MessageBotStream(stream, controller)
                : createBotSelectableText(displayMsg, context))
      ])),
      const SizedBox(width: 40.0)
    ]);
  }
}

///
/// StreamBuilder
///
class MessageBotStream extends ConsumerWidget {
  const MessageBotStream(this.stream, this.controller, {super.key});

  final Stream<String>? stream;

  //滚动控制
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: stream,
      key: Key('${Random().nextDouble()}'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text("${t.app.error}: ${snapshot.error}");
        }
        if (snapshot.hasData) {
          String content = snapshot.data ?? "";
          scrollEnd(controller, 200);
          if (content.isNotEmpty) return Text(content);
        }
        return const MessageLoading();
      },
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';
import 'package:frontend/utils/sp_provider.dart';
import 'package:frontend/widget/message_loading.dart';
import 'package:frontend/widget/show_snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// Generate Bot
///
class GenerateBotView extends StatelessWidget {
  GenerateBotView(this.listScrollController, {super.key});

  //滚动控制
  final ScrollController listScrollController;

  final String time = DateTime.now().toString();

  String checkTimeStr() {
    return time.substring(0, time.indexOf('.'));
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2))
                ]),
            child: GenerateBotMessage(listScrollController)),
        const SizedBox(height: 4),
        //复制文本
        const CopyContent()
      ])),
    ]);
  }
}

///
/// Copy Content
///
class CopyContent extends ConsumerWidget {
  const CopyContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final writeState = ref.watch(writeStateProvider);
    return Visibility(
        visible: writeState.code == 1,
        child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextButton.icon(
                onPressed: () {
                  final content = SpProvider().getString('generate_content');
                  if (content.isEmpty) return;
                  Clipboard.setData(ClipboardData(text: content));
                  showSnackBar(t.write.copy_success);
                },
                icon: const Icon(Icons.copy_rounded, size: 16),
                label: Text(t.write.copy))));
  }
}

///
/// StreamBuilder
/// SelectableText
///
class GenerateBotMessage extends ConsumerStatefulWidget {
  const GenerateBotMessage(this.listScrollController, {super.key});

  //滚动控制
  final ScrollController listScrollController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return GenerateBotMessageState();
  }
}

class GenerateBotMessageState extends ConsumerState<GenerateBotMessage> {
  @override
  Widget build(BuildContext context) {
    final startGenerate = ref.watch(startGenerateProvider);
    return startGenerate['system'] == null
        ? SelectableText(t.write.wait_execute)
        : StreamBuilder(
            stream: ref.read(writeStateProvider.notifier).sendMessageStreamApi(
                startGenerate['system'], startGenerate['prompt']),
            key: Key('${Random().nextDouble()}'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) {
                return SelectableText("${t.app.error}: ${snapshot.error}");
              }
              if (snapshot.hasData) {
                String content = snapshot.data ?? "";
                scrollEnd(widget.listScrollController, 200);
                if (content.isNotEmpty) return Text(content);
              }
              return const MessageLoading();
            });
  }
}

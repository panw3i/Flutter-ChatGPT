import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/widget/message_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/provider/translate_provider.dart';
import 'package:frontend/pages/translate/view/ui_states.dart';

///
/// 智能翻译流式生成文本[translate message stream returning]
///
class TranslateMessage extends ConsumerWidget {
  TranslateMessage({super.key});

  /// 生成内容滚动控制[content scroll control]
  final ScrollController _listScrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(translateInputProvider);
    return ListView(controller: _listScrollController, children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          child: message.keys.first
              ? streamBuilder(ref, message.values.first)
              : SelectableText(message.values.first),
        )
      ])
    ]);
  }

  ///
  /// StreamBuilder
  ///
  Widget streamBuilder(WidgetRef ref, String message) {
    return StreamBuilder(
      stream: stream(ref, message),
      key: Key('${Random().nextDouble()}'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return SelectableText("${t.app.error}: ${snapshot.error}");
        }
        if (snapshot.hasData) {
          String content = snapshot.data ?? "";
          scrollEnd(_listScrollController, 200);
          if (content.isNotEmpty) return Text(content);
        }
        return const MessageLoading();
      },
    );
  }
}

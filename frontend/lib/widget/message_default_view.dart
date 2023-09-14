import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';

///
/// 消息列表默认展示页面[Message Default Widget]
///
class MessageDefaultView extends StatelessWidget {
  const MessageDefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/ic_bot_default.png', width: 112, height: 112),
        TextLiquidFill(
            text: t.home.appbar_action,
            waveColor: Theme.of(context).colorScheme.secondary,
            boxWidth: 752,
            boxHeight: 160,
            loadDuration: const Duration(seconds: 2),
            waveDuration: const Duration(seconds: 1),
            boxBackgroundColor: Theme.of(context).colorScheme.surface,
            textStyle: style48),
      ],
    )));
  }
}

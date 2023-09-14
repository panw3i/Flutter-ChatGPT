import 'package:flutter/material.dart';
import 'package:frontend/pages/message/ui_widgets.dart';
import 'package:frontend/utils/style_provider.dart';

///
/// AI-User chat message widget
///
class MessageUserView extends StatelessWidget {
  const MessageUserView(this.displayMsg, this.displayTime, {Key? key})
      : super(key: key);

  //当前显示消息
  final String displayMsg;

  final String displayTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 40.0),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(checkTimeStr(displayTime), style: style14),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    // color: Theme.of(context).colorScheme.secondaryContainer,
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: createUserSelectableText(displayMsg, context),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: createUserAvatar(),
        ),
      ],
    );
  }
}

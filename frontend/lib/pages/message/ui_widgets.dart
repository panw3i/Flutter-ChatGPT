import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:frontend/widget/show_snackbar.dart';

///
/// 创建可选中文本[SelectableText]
///
Widget createUserSelectableText(String text, BuildContext context) {
  return SelectableText(
    text,
    style: TextStyle(
      fontSize: 14,
      color: colorScheme(context).onSecondaryContainer,
    ),
  );
}

///
/// 创建可选中文本[SelectableText]
///
Widget createBotSelectableText(String text, BuildContext context) {
  return SelectableText(
    text,
    style: TextStyle(
      color: Theme.of(context).colorScheme.onTertiaryContainer,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );
}

ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;

///
/// 创建复制Widget[Copy TextButton]
///
Widget createCopyTextButton(String copyText) {
  return TextButton.icon(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: copyText));
        showSnackBar(t.write.copy_success);
      },
      icon: const Icon(Icons.copy_rounded, size: 20),
      label: Text(t.write.copy, style: style14));
}

///
/// 创建助手消息Widget[timeline text]
///
Widget createTimeText(BuildContext context, String timeText) {
  return Text(timeText,
      style: TextStyle(
          fontSize: 14, color: Theme.of(context).colorScheme.primary));
}

///
/// 创建头像Widget[avatar image]
///
Widget createUserAvatar() {
  return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/ic_user.webp'), radius: 16.0);
}

Widget createBotAvatar() {
  return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/ic_bot.png'),
      radius: 16.0,
      backgroundColor: Colors.transparent);
}

///
/// 逐字打印滚动[ScrollController,scroll content to end]
///
void scrollEnd(ScrollController controller, int milliseconds) {
  if (controller.positions.isEmpty) return;
  controller.animateTo(controller.position.maxScrollExtent,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeOutQuart);
}

///
/// check time length and substring it
///
String checkTimeStr(String displayTime) {
  if (displayTime.isEmpty) return '';
  if (!displayTime.contains('.')) return displayTime;
  if (displayTime.length != 23) return displayTime;
  return displayTime.substring(0, displayTime.indexOf('.'));
}

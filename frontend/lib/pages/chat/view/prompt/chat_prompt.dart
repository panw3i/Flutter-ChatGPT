import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/view/prompt/ui_states.dart';
import 'package:frontend/pages/chat/view/prompt/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 预设聊天主题[prepared prompt grid list]
///
class ChatPrompt extends StatelessWidget {
  const ChatPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 268,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: const EdgeInsets.only(bottom: 24, top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 0.2),
            color: Theme.of(context).navigationDrawerTheme.surfaceTintColor),
        child: createPromptGrid(context, (title, prompt) {
          showEditDialog(context, title, prompt);
        }));
  }

  ///
  /// 显示prompt编辑框[edit prompt alert dialog]
  ///
  showEditDialog(
      BuildContext context, String promptTitle, String promptContent) {
    showDialog(
        context: context,
        builder: (context) => EditPromptDialog(promptTitle, promptContent));
  }
}

///
/// 编辑prompt模版 - dialog
///
class EditPromptDialog extends ConsumerWidget {
  EditPromptDialog(this.promptTitle, String promptContent, {super.key}) {
    controller = TextEditingController(text: promptContent);
  }

  final String promptTitle;
  late final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoading = watchProgress(ref);
    return createAlertDialog(context, promptTitle.replaceAll("\n", " "), controller, showLoading, () {
      addConversation(ref, promptTitle.replaceAll("\n", " "), controller.text,
          () => updateProgress(ref, true), () => Navigator.of(context).pop());
    });
  }
}

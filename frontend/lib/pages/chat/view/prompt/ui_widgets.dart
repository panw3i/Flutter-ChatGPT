import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/chat/view/conversation/ui_widgets.dart';
import 'package:frontend/utils/style_provider.dart';

final titleStr = [
  t.chat.chat_prompt_topic1,
  t.chat.chat_prompt_topic2,
  t.chat.chat_prompt_topic3,
  t.chat.chat_prompt_topic4,
  t.chat.chat_prompt_topic5,
  t.chat.chat_prompt_topic6,
  t.chat.chat_prompt_topic7,
  t.chat.chat_prompt_topic8,
  t.chat.chat_prompt_topic9,
  t.chat.chat_prompt_topic10,
  t.chat.chat_prompt_topic11,
  t.chat.chat_prompt_topic12
];

final promptStr = [
  t.chat.chat_prompt_content1,
  t.chat.chat_prompt_content2,
  t.chat.chat_prompt_content3,
  t.chat.chat_prompt_content4,
  t.chat.chat_prompt_content5,
  t.chat.chat_prompt_content6,
  t.chat.chat_prompt_content7,
  t.chat.chat_prompt_content8,
  t.chat.chat_prompt_content9,
  t.chat.chat_prompt_content10,
  t.chat.chat_prompt_content11,
  t.chat.chat_prompt_content12
];

///
/// Prompt Grid
///
Widget createPromptGrid(BuildContext context, Function(String, String) onTap,
    {List<String>? titleList, List<String>? promptList}) {
  return GridView.builder(
    itemCount: titleList == null ? titleStr.length : titleList.length,
    itemBuilder: (context, index) {
      final title = titleList == null ? titleStr[index] : titleList[index];
      final prompt = promptList == null ? promptStr[index] : promptList[index];
      return Card(
        elevation: 0.6,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: () => onTap(title, prompt),
          child: createPromptGridContent(context, title),
        ),
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
  );
}

///
/// Prompt Grid Content
///
Widget createPromptGridContent(BuildContext context, String title) {
  return Container(
    height: 100,
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Container(alignment: Alignment.center, child: Text(title))),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.subject, size: 12),
              const SizedBox(width: 4),
              Text(t.chat.prompt, style: style12),
            ],
          ),
        ),
      ],
    ),
  );
}

///
/// AlertDialog
///
Widget createAlertDialog(BuildContext context, String promptTitle,
    TextEditingController controller, bool showLoading, VoidCallback confirm) {
  return AlertDialog(
      title: Text(promptTitle),
      content: createTextField(controller),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (!showLoading) {
                Navigator.of(context).pop();
              }
            },
            child: Text(t.app.cancel)),
        ElevatedButton(
            onPressed: () {
              confirm();
            },
            child: showLoading
                ? const SizedBox(
                    width: 24, height: 24, child: CircularProgressIndicator())
                : Text(t.app.confirm))
      ]);
}

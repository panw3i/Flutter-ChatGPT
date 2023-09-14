import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/write/model/prompt_info.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final promptList = [
  PromptInfo(
      title: t.task.prompt_title_one,
      content: t.task.prompt_content_one,
      label: t.task.prompt_label_one),
  PromptInfo(
      title: t.task.prompt_title_two,
      content: t.task.prompt_content_two,
      label: t.task.prompt_label_two),
  PromptInfo(
      title: t.task.prompt_title_three,
      content: t.task.prompt_content_three,
      label: t.task.prompt_label_three),
];

///
/// Task Prompt Grid
///
Widget createPromptGrid(WidgetRef ref, Function(String) onTap) {
  return GridView.builder(
    itemCount: promptList.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final data = promptList[index];
      final titleStr = data.title;
      final contentStr = data.content;
      final labelStr = data.label;
      return Card(
          borderOnForeground: false,
          elevation: 0.6,
          child: InkWell(
              onTap: () => onTap(contentStr),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: createGridContent(titleStr, contentStr, labelStr)));
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.45,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24),
  );
}

///
/// Task Prompt Grid Content
///
Widget createGridContent(String titleStr, String contentStr, String labelStr) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              tooltip: t.task.task_name,
              icon: const Icon(Icons.task)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(titleStr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              tooltip: labelStr,
              icon: const Icon(Icons.info_outline),
              iconSize: 20),
        ]),
        // const SizedBox(height: 4),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(contentStr,
                softWrap: false,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: style13),
          ),
        ),
      ],
    ),
  );
}

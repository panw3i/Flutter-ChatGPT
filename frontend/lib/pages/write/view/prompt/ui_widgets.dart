import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/write/model/prompt_info.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Text Summaries
final bigText = t.app.big_text;
final label = t.write.write_prompt_label;

final promptList = [
  PromptInfo(
      title: t.write.write_prompt_title1,
      content: t.write.write_prompt_content1,
      label: label,
      topic: t.write.write_prompt_topic1,
      prompt: t.write.write_prompt_1,
      system: t.write.write_prompt_system1),
  PromptInfo(
      title: t.write.write_prompt_title2,
      content: t.write.write_prompt_content2,
      label: label,
      topic: t.write.write_prompt_topic2,
      prompt: t.write.write_prompt_2,
      system: t.write.write_prompt_system2),
  PromptInfo(
      title: t.write.write_prompt_title3,
      content: t.write.write_prompt_content3,
      label: label,
      topic: t.write.write_prompt_topic3,
      prompt: bigText,
      system: t.write.write_prompt_system3),
  PromptInfo(
      title: t.write.write_prompt_title4,
      content: t.write.write_prompt_content4,
      label: label,
      topic: t.write.write_prompt_topic4,
      prompt: bigText,
      system: t.write.write_prompt_system4),
  PromptInfo(
      title: t.write.write_prompt_title5,
      content: t.write.write_prompt_content5,
      label: label,
      topic: t.write.write_prompt_topic5,
      prompt: t.write.write_prompt_5,
      system: t.write.write_prompt_system5),
  PromptInfo(
      title: t.write.write_prompt_title6,
      content: t.write.write_prompt_content6,
      label: label,
      topic: t.write.write_prompt_topic6,
      prompt: t.write.write_prompt_6,
      system: t.write.write_prompt_system6),
  PromptInfo(
      title: t.write.write_prompt_title7,
      content: t.write.write_prompt_content7,
      label: label,
      topic: t.write.write_prompt_topic7,
      prompt: t.write.write_prompt_7,
      system: t.write.write_prompt_system7),
];

///
/// Prompt Template Grid
///
Widget createPromptGrid(
    BoxConstraints constraints, WidgetRef ref, Function(PromptInfo) onTap) {
  return GridView.builder(
    itemCount: promptList.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final data = promptList[index];
      return Card(
        borderOnForeground: false,
        elevation: 0.6,
        child: InkWell(
            onTap: () => onTap(data),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: createPromptGridContent(data)),
      );
    },
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth > 700 ? 3 : 1,
        childAspectRatio: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16),
  );
}

///
/// Prompt Template Grid Content
///
Widget createPromptGridContent(PromptInfo data) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              tooltip: t.write.prompt_name,
              icon: const Icon(Icons.topic)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(data.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              tooltip: data.prompt,
              icon: const Icon(Icons.info_outline),
              iconSize: 20),
        ]),
        const SizedBox(height: 8),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(data.content, style: style15))),
        Align(
          alignment: Alignment.bottomRight,
          child: FilledButton.tonal(
            onPressed: () {},
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 8)),
                minimumSize:
                    const MaterialStatePropertyAll<Size>(Size(40, 34))),
            child: Text(data.label, style: style13),
          ),
        ),
      ],
    ),
  );
}

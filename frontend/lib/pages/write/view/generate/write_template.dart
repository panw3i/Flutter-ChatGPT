import 'package:flutter/material.dart';
import 'package:frontend/pages/write/view/generate/template_content.dart';
import 'package:frontend/pages/write/view/generate/ui_states.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// Prompt Template
///
class GenerateTemplate extends ConsumerWidget {
  GenerateTemplate({super.key});

  //系统角色[System Role]
  late final controlSystem = TextEditingController();

  //提示词[User Prompt]
  late final controlPrompt = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promptInfo = watchPromptInfo(ref);
    final writeState = watchWriteState(ref);
    listenResetPrompt(ref, controlSystem, controlPrompt);
    listenPromptInfo(ref, controlSystem, controlPrompt);
    listenWriteState(ref, controlSystem, controlPrompt);
    return Expanded(
      child: Card(
        elevation: 0.5,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              //模版名称(图标，title)
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.topic),
                label: Text(promptInfo.title, style: style18),
              ),
              Expanded(
                  child: TemplateContent(
                      promptInfo, controlSystem, controlPrompt, writeState)),
            ],
          ),
        ),
      ),
    );
  }
}

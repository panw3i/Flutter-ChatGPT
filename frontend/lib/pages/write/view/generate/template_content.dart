import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/write/model/prompt_info.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';
import 'package:frontend/pages/write/view/generate/ui_states.dart';
import 'package:frontend/pages/write/view/generate/ui_widgets.dart';
import 'package:frontend/widget/show_snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// Write Template Content
///
class TemplateContent extends ConsumerWidget {
  const TemplateContent(
      this.promptInfo, this.controlSystem, this.controlPrompt, this.writeState,
      {super.key});

  final PromptInfo promptInfo;
  final TextEditingController controlSystem;
  final TextEditingController controlPrompt;
  final WriteState writeState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(children: [
      const SizedBox(height: 16),
      //主题名称
      createText(context, promptInfo.topic),
      const SizedBox(height: 16),
      //系统角色内容
      createSystemRoleInput(context, controlSystem),
      const SizedBox(height: 16),
      //提示词内容，生成文本指令
      createText(context, promptInfo.content),
      const SizedBox(height: 16),
      createSystemPromptInput(context, controlPrompt),
      const SizedBox(height: 48),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: FloatingActionButton.extended(
              onPressed: () => resetTemplate(ref),
              foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26)),
              icon: Icon(Icons.restart_alt,
                  color: Theme.of(context).colorScheme.outline),
              label: Text(t.write.reset_template,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.outline)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: FloatingActionButton.extended(
                onPressed: () {
                  if (controlSystem.text.isEmpty ||
                      controlPrompt.text.isEmpty) {
                    showSnackBar(t.write.check_template_tip);
                    return;
                  }
                  if (writeState.code == 0) return;
                  startGenerate(ref, controlSystem.text, controlPrompt.text);
                },
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                icon: writeState.code == 0
                    ? const SizedBox.shrink()
                    : createStartGenerateIcon(context),
                label: writeState.code == 0
                    ? showProgress()
                    : createStartGenerateText(context)),
          )
        ],
      )
    ]);
  }
}

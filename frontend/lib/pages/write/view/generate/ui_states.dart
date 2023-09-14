import 'package:flutter/material.dart';
import 'package:frontend/pages/write/model/prompt_info.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';
import 'package:frontend/widget/show_snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// listen [PromptInfo] model
///
PromptInfo watchPromptInfo(WidgetRef ref) => ref.watch(promptInfoProvider);

listenPromptInfo(WidgetRef ref, TextEditingController controlSystem,
    TextEditingController controlPrompt) {
  ref.listen(promptInfoProvider, (previous, next) {
    controlSystem.text = next.system;
    controlPrompt.text = next.prompt;
  });
}

///
/// listen [WriteState]
///
WriteState watchWriteState(WidgetRef ref) => ref.watch(writeStateProvider);

listenWriteState(WidgetRef ref, TextEditingController controlSystem,
    TextEditingController controlPrompt) {
  ref.listen(writeStateProvider, (previous, next) {
    switch (next.code) {
      case 0:
      case 1:
      case 2:
        showSnackBar(next.msg);
        break;
    }
  });
}

///
/// listen reset prompt
///
listenResetPrompt(WidgetRef ref, TextEditingController controlSystem,
    TextEditingController controlPrompt) {
  ref.listen(clearPromptInfoProvider, (previous, next) {
    controlSystem.clear();
    controlPrompt.clear();
  });
}

///
/// Reset Template
///
resetTemplate(WidgetRef ref) {
  ref
      .read(clearPromptInfoProvider.notifier)
      .update((state) => getDefaultPromptInfo());
}

///
/// Start Generate
///
startGenerate(WidgetRef ref, String system, String prompt) {
  ref
      .read(startGenerateProvider.notifier)
      .update((state) => {'system': system, 'prompt': prompt});
  ref.read(showCopyProvider.notifier).update((state) => false);
}

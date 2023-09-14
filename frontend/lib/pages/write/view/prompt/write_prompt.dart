import 'package:flutter/material.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';
import 'package:frontend/pages/write/view/prompt/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// Prompt Template
///
class WritePrompt extends ConsumerStatefulWidget {
  const WritePrompt({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WritePromptState();
  }
}

///提示词列表
class WritePromptState extends ConsumerState<WritePrompt>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 16, left: 16),
      constraints: const BoxConstraints(minWidth: 360, maxWidth: 1024),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return createPromptGrid(constraints, ref, (data) {
            ref.read(writeWorkspaceProvider.notifier).update((state) => 1);
            Future.delayed(const Duration(milliseconds: 160), () {
              ref.read(promptInfoProvider.notifier).update((state) => data);
              ref.read(startGenerateProvider.notifier).update((state) => {});
            });
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

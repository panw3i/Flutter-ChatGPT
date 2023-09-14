import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/task/view/prompt/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/task/provider/task_provider.dart';

///
/// Task prompt template
///
class TaskPrompt extends ConsumerStatefulWidget {
  const TaskPrompt({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TaskPromptState();
  }
}

///提示词列表
class TaskPromptState extends ConsumerState<TaskPrompt>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final allowInput = ref.watch(allowInputTaskProvider);
    super.build(context);
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 8),
      height: 128,
      child: createPromptGrid(ref, (str) => handlePromptStr(str, allowInput)),
    );
  }

  ///
  /// 处理选中主题[handle prompt template]
  ///
  handlePromptStr(String contentStr, bool allowInput) async {
    if (!allowInput) return;
    await ref.read(taskStateProvider.notifier).addMessages(contentStr);
    ref.read(taskStateProvider.notifier).queryMessage();
    ref
        .read(sendMessageTaskProvider.notifier)
        .update((state) => state = Random().nextDouble());
  }

  @override
  bool get wantKeepAlive => true;
}

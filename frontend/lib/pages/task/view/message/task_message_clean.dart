import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/task/repository/task_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:frontend/pages/task/provider/task_provider.dart';

///
/// 清理任务对话记录[clean task conversation messages]
///
class TaskMessageClean extends ConsumerWidget {
  const TaskMessageClean({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowInput = ref.watch(allowInputTaskProvider);
    return Container(
        width: 128,
        padding: const EdgeInsets.only(right: 16, bottom: 4),
        child: FloatingActionButton(
            tooltip: t.app.clear,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            elevation: 6,
            onPressed: () {
              if (allowInput) {
                cleanMessage(ref);
                return;
              }
            },
            child: Row(children: [
              const SizedBox(width: 8),
              Image.asset('assets/images/ic_clean.png', width: 24, height: 24),
              const SizedBox(width: 8),
              Text(t.app.clear)
            ])));
  }

  ///
  /// 清除当前文件对话下消息[clean task conversation messages]
  ///
  void cleanMessage(WidgetRef ref) async {
    ref.read(taskStateProvider.notifier).clearMessage();
    ref.read(taskStateProvider.notifier).queryMessage();
  }
}

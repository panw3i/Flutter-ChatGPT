import 'package:flutter/material.dart';
import 'package:frontend/pages/task/view/input/task_input.dart';
import 'package:frontend/pages/task/view/message/task_message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/task/view/message/task_message_clean.dart';
import 'package:frontend/pages/task/view/prompt/task_prompt.dart';

///
/// 智能任务(考勤、库存、休假)
/// [AI-Task(Attendance、inventory、leave)]
///
class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TaskPageState();
  }
}

class TaskPageState extends ConsumerState<TaskPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(scrollDirection: Axis.horizontal, children: [
      Container(
        margin: const EdgeInsets.only(left: 212),
        constraints: const BoxConstraints(minWidth: 360, maxWidth: 1024),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          //顶部任务类型[Top-prompt]
          const TaskPrompt(),
          //中间消息展示[Middle-message]
          Expanded(
              child: Container(
                  width: 880,
                  alignment: Alignment.center,
                  child: const TaskMessage())),
          //底部文本输入与清除[Bottom-input and clean]
          Padding(
            padding: const EdgeInsets.only(left: 64, bottom: 16),
            child: Row(children: [const TaskMessageClean(), TaskInput()]),
          ),
        ]),
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}

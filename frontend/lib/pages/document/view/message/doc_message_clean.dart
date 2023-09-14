import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:frontend/pages/document/model/doc_selected.dart';
import 'package:frontend/pages/document/provider/doc_provider.dart';

///
/// 清理文档对话记录[clean doc messages]
///
class DocMessageClean extends ConsumerWidget {
  const DocMessageClean({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(chatSelectedDocProvider);
    final allowInput = ref.watch(allowInputDocProvider);
    return Visibility(
      visible: selected.conversationId != null,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 4),
        child: FloatingActionButton(
            tooltip: t.app.clear,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            elevation: 6,
            child: Image.asset('assets/images/ic_clean.png',
                width: 24, height: 24),
            onPressed: () => cleanMessage(ref, selected, allowInput)),
      ),
    );
  }

  ///
  /// 清除当前文件对话下消息[clean doc conversation messages]
  ///
  void cleanMessage(
      WidgetRef ref, DocSelected selected, bool allowInput) async {
    if (!allowInput) return;
    final id = selected.conversationId;
    await ref.read(conversationDocProvider.notifier).deleteMessages(id);
    await ref.read(conversationDocProvider.notifier).addDefaultMessages(id);
    ref.read(conversationDocProvider.notifier).queryMessagesWithId(id);
  }
}

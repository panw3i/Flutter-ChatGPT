import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/document/view/conversation/ui_states.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 文档上传(状态管理、文档对话新增)[doc upload]
///
class DocUpload extends ConsumerWidget {
  const DocUpload(this.conversations, this.status, {super.key});

  final List<Conversations>? conversations;
  final int status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 72,
      width: 256,
      child: FloatingActionButton.extended(
        onPressed: () {
          addDocConversation(conversations, ref);
        },
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        label: status == 0 ? showProgress() : showContent(),
      ),
    );
  }

  ///
  /// upload state
  ///
  Widget showProgress() {
    return const SizedBox(
        width: 36, height: 36, child: CircularProgressIndicator());
  }

  ///
  /// upload widget
  ///
  Widget showContent() {
    return Column(children: [
      Row(children: [
        const Icon(Icons.add),
        const SizedBox(width: 8),
        Text(
            textAlign: TextAlign.center, t.document.upload_file, style: style16)
      ]),
      const SizedBox(height: 4),
      const Text(
          textAlign: TextAlign.center, 'PDF·DOCX·TXT·PPT·MD', style: style12)
    ]);
  }
}

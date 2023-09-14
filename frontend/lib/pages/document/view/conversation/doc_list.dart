import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/pages/document/view/conversation/ui_states.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 文档列表[doc list]
///
class DocConversationList extends ConsumerWidget {
  const DocConversationList(this.conversations, {super.key});

  final List<Conversations>? conversations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = watchDocChatSelected(ref);
    listenDocChatSelected(ref);
    return ListView.separated(
        itemCount: conversations?.length ?? 0,
        itemBuilder: (context, index) {
          final conversation = conversations![index];
          final titleStr = conversation.title ?? '';
          final isSelected = selected.conversationId == conversation.id;
          return ListTile(
            // horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.only(left: 16),
            mouseCursor: SystemMouseCursors.click,
            selected: isSelected,
            onTap: () => onTapDocConversation(index, conversation, ref),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26))),
            hoverColor: Theme.of(context).colorScheme.surfaceVariant,
            title: Text(
              titleStr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style15,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8));
  }
}

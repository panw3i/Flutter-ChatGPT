import 'package:flutter/material.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/chat/model/chat_selected.dart';
import 'package:frontend/utils/style_provider.dart';

///
/// 创建聊天按钮[create chat button]
///
Widget createFloatingActionButton(VoidCallback onPressed) {
  return FloatingActionButton.extended(
      onPressed: onPressed,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26))),
      label: Row(children: [
        const Icon(Icons.add),
        const SizedBox(width: 8),
        Text(t.chat.create_chat)
      ]));
}

///
/// 创建对话列表[create conversation list]
///
Widget createConversationList(
    List<Conversations>? conversations,
    ChatSelected selected,
    Function(ChatSelected) onTap,
    Function(Conversations) editConversation,
    Function(Conversations, bool) deleteConversation) {
  return ListView.separated(
      itemCount: conversations?.length ?? 0,
      itemBuilder: (context, index) {
        final conversation = conversations![index];
        final titleStr = conversation.title ?? '';
        final isSelected = selected.conversationId == conversation.id;
        return ListTile(
            contentPadding: const EdgeInsets.only(left: 16),
            mouseCursor: SystemMouseCursors.click,
            selected: isSelected,
            onTap: () => onTap(
                ChatSelected(index: index, conversationId: conversation.id)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(26))),
            hoverColor: Theme.of(context).colorScheme.surfaceVariant,
            title: Text(titleStr,
                maxLines: 1, overflow: TextOverflow.ellipsis, style: style15),
            trailing: createConversationTrailing(conversation, isSelected,
                editConversation, deleteConversation));
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8));
}

///
/// 创建对话菜单操作[create conversation trailing operation]
///
Widget createConversationTrailing(
    Conversations conversations,
    bool currentSelect,
    Function(Conversations) editConversation,
    Function(Conversations, bool) deleteConversation) {
  return MenuAnchor(
      style: MenuStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      builder: (_, MenuController controller, __) {
        return IconButton(
            onPressed: () {
              controller.isOpen ? controller.close() : controller.open();
            },
            tooltip: t.app.more,
            icon: const Icon(Icons.more_vert_outlined, size: 20));
      },
      menuChildren: [
        MenuItemButton(
            child: SizedBox(
                width: 128,
                height: 48,
                child: Row(children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.edit, size: 20),
                  const SizedBox(width: 8),
                  Text(t.app.edit, style: style15)
                ])),
            onPressed: () {
              editConversation(conversations);
            }),
        MenuItemButton(
            child: SizedBox(
                width: 112,
                height: 48,
                child: Row(children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.delete, size: 20),
                  const SizedBox(width: 8),
                  Text(t.app.delete, style: style15)
                ])),
            onPressed: () {
              deleteConversation(conversations, currentSelect);
            })
      ]);
}

///
/// 创建编辑对话主题名称弹框[create prompt alert dialog]
///
Widget createAlertDialog(BuildContext context, TextEditingController controller,
    Function(String) confirm) {
  return AlertDialog(
      title: Text(t.chat.edit_prompt),
      content: createTextField(controller),
      actions: [
        createElevatedButton(context, () {}, t.app.cancel),
        createElevatedButton(
            context, () => confirm(controller.text), t.app.confirm)
      ]);
}

///
/// 编辑对话名称TextField
///
Widget createTextField(TextEditingController controller) {
  return SizedBox(
    height: 128,
    width: 512,
    child: TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      expands: true,
      showCursor: true,
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: t.chat.edit_prompt_hint,
        counter: const SizedBox(width: 0, height: 0),
        isCollapsed: true,
        hoverColor: const Color(0xFFCAC4D0),
        contentPadding: const EdgeInsets.only(top: 18),
      ),
    ),
  );
}

///
/// 创建AlertDialog操作按钮
///
Widget createElevatedButton(
    BuildContext context, VoidCallback onPressed, String text) {
  return ElevatedButton(
      onPressed: () {
        onPressed();
        Navigator.of(context).pop();
      },
      child: Text(text));
}

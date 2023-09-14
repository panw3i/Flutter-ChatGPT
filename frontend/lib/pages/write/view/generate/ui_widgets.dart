import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';

Widget showProgress() {
  return const SizedBox(
      width: 36, height: 36, child: CircularProgressIndicator());
}

///
/// [Start Generate]
///
Widget createStartGenerateText(BuildContext context) {
  return Text(t.write.start_generate,
      style: TextStyle(
          fontSize: 18, color: Theme.of(context).colorScheme.primary));
}

///
/// [Reset Template]
///
Widget createResetTemplateText(BuildContext context) {
  return Text(t.write.start_generate,
      style: TextStyle(
          fontSize: 18, color: Theme.of(context).colorScheme.primary));
}

Widget createStartGenerateIcon(BuildContext context) {
  return Icon(Icons.start, color: Theme.of(context).colorScheme.primary);
}

///
/// [Text]
///
Widget createText(BuildContext context, String str) {
  return Text(str,
      style: TextStyle(
          fontSize: 16, color: Theme.of(context).colorScheme.outline));
}

///
/// [System Role Input]
///
Widget createSystemRoleInput(
    BuildContext context, TextEditingController controlSystem) {
  return SizedBox(
    height: 144,
    child: TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      expands: true,
      showCursor: true,
      autofocus: true,
      maxLength: 200,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.scrim),
      controller: controlSystem,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: t.write.system_role_tip,
        // counter: const SizedBox(width: 0, height: 0),
        isCollapsed: true,
        hoverColor: const Color(0xFFCAC4D0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    ),
  );
}

///
/// [System Prompt Input]
///
Widget createSystemPromptInput(
    BuildContext context, TextEditingController controlPrompt) {
  return SizedBox(
    height: 160,
    child: TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      expands: true,
      showCursor: true,
      autofocus: true,
      maxLength: 2000,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.scrim),
      controller: controlPrompt,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: t.write.system_prompt_tip,
        // counter: const SizedBox(width: 0, height: 0),
        isCollapsed: true,
        hoverColor: const Color(0xFFCAC4D0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    ),
  );
}

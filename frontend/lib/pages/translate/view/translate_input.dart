import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/model/language_bean.dart';
import 'package:frontend/pages/translate/provider/translate_provider.dart';

///
/// 翻译输入[start translate input]
///
class TranslateInput extends ConsumerWidget {
  TranslateInput(this.inputControl, this.inputLanguage, {super.key});

  final FocusNode focusNode = FocusNode();
  final TextEditingController inputControl;
  final List<LanguageBean> inputLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(updateLanguageProvider);
    ref.listen(updateLanguageProvider, (previous, next) {
      focusNode.requestFocus();
    });
    return TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        expands: true,
        showCursor: true,
        autofocus: true,
        focusNode: focusNode,
        maxLength: 1000,
        controller: inputControl,
        style: style16,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: inputLanguage.firstWhere((i) => i.checked == true).hint ??
              t.translate.translate_check_empty,
          isCollapsed: true,
          hoverColor: const Color(0xFFCAC4D0),
        ));
  }
}

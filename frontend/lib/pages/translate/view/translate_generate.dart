import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/translate/view/ui_states.dart';
import 'package:frontend/pages/translate/view/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/model/language_bean.dart';
import 'package:frontend/pages/translate/provider/translate_provider.dart';
import 'package:frontend/widget/show_snackbar.dart';

///
/// 执行开始翻译[start translate generate]
///
class TranslateGenerate extends ConsumerWidget {
  const TranslateGenerate(
      this.inputControl, this.inputLanguage, this.targetLanguage,
      {super.key});

  final TextEditingController inputControl;
  final List<LanguageBean> inputLanguage;
  final List<LanguageBean> targetLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoading = ref.watch(showGenerateProvider);
    return showLoading == true
        ? const SizedBox(
            width: 64, height: 64, child: CircularProgressIndicator())
        : SizedBox(
            width: 256,
            child: createTranslateButton(context, () => translateInput(ref)),
          );
  }

  ///
  /// 翻译输入内容[start translate generate content]
  ///
  void translateInput(WidgetRef ref) {
    final inputStr = inputControl.text.trim();
    if (inputStr.isEmpty) {
      showSnackBar(t.translate.translate_check_empty);
      return;
    }
    final inputType =
        inputLanguage.firstWhere((element) => element.checked == true).name;
    final targetType =
        targetLanguage.firstWhere((element) => element.checked == true).name;
    if (inputType == targetType) {
      showSnackBar(t.translate.translate_check_type);
      return;
    }
    translateBotMessage(inputType!, targetType!, inputStr, ref);
  }
}

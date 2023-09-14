import 'package:flutter/material.dart';
import 'package:frontend/pages/translate/view/ui_states.dart';
import 'package:frontend/pages/translate/view/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/model/language_bean.dart';
import 'package:frontend/pages/translate/provider/translate_provider.dart';
import 'package:frontend/utils/sp_provider.dart';

///
/// 翻译语言下拉菜单、语言切换[translate language menu and change]
///
class TranslateLanguage extends ConsumerWidget {
  TranslateLanguage(this.inputControl, this.inputLanguage, this.targetLanguage,
      {super.key});

  final MenuController menuInputController = MenuController();
  final MenuController menuTargetController = MenuController();

  final TextEditingController inputControl;
  final List<LanguageBean> inputLanguage;
  final List<LanguageBean> targetLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(updateLanguageProvider);
    ref.watch(translateInputProvider);
    final inputChecked =
        inputLanguage.firstWhere((element) => element.checked == true);
    final targetChecked =
        targetLanguage.firstWhere((element) => element.checked == true);
    return Container(
      constraints: const BoxConstraints(minWidth: 360, maxWidth: 1000),
      height: 64,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 左侧语言菜单[left language menu]
            languageMenu(
                inputChecked.code ?? '',
                inputChecked.native ?? '',
                inputLanguage,
                menuInputController,
                () => handleShowMenu(menuInputController),
                (p0) => handleMenuSelected(
                    menuInputController, ref, inputLanguage, p0)),

            /// 语言菜单切换[language change]
            createChangeLanguageButton(context, () {
              for (var element in inputLanguage) {
                element.checked = element.code == targetChecked.code;
              }
              for (var element in targetLanguage) {
                element.checked = element.code == inputChecked.code;
              }
              if (inputControl.text.isNotEmpty &&
                  SpProvider().getString('translate').isNotEmpty) {
                final inputStr = inputControl.text;
                final targetStr = SpProvider().getString('translate');
                inputControl.text = targetStr;
                SpProvider().setString('translate', inputStr);

                /// 显示用户输入待翻译内容[show user input str]
                translateUserMessage(ref, inputStr);
              }

              /// 输入内容[update widget state]
              updateLanguage(ref);
            }),

            /// 右侧语言菜单[right language menu]
            languageMenu(
                targetChecked.code ?? '',
                targetChecked.native ?? '',
                targetLanguage,
                menuTargetController,
                () => handleShowMenu(menuTargetController),
                (p0) => handleMenuSelected(
                    menuTargetController, ref, targetLanguage, p0)),
          ],
        ),
      ),
    );
  }

  ///
  /// 显示菜单menu[MenuController]
  ///
  handleShowMenu(MenuController controller) {
    controller.isOpen == true ? controller.close() : controller.open();
  }

  ///
  /// 选中菜单[menu selected]
  ///
  handleMenuSelected(MenuController controller, WidgetRef ref,
      List<LanguageBean> list, LanguageBean? bean) {
    for (var element in list) {
      element.checked = element.code == bean?.code;
    }
    updateLanguage(ref);
    controller.isOpen == true ? controller.close() : controller.open();
  }
}

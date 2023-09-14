import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/translate/model/language_bean.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/style_provider.dart';

///
/// LanguageBean
///
final inputLanguage = [
  LanguageBean(
      code: 'zh',
      name: 'Chinese',
      native: t.translate.language_native_zh,
      checked: true,
      hint: '请输入待翻译内容'),
  LanguageBean(
      code: 'ru',
      name: 'Russian',
      native: t.translate.language_native_ru,
      hint: 'Пожалуйста, введите текст для перевода'),
  LanguageBean(
      code: 'en',
      name: 'English',
      native: t.translate.language_native_en,
      hint: 'Please enter the content to be translated'),
  LanguageBean(
      code: 'fr',
      name: 'French',
      native: t.translate.language_native_fr,
      hint: 'Veuillez entrer le contenu à traduire'),
  LanguageBean(
      code: 'de',
      name: 'German',
      native: t.translate.language_native_de,
      hint: 'Bitte geben Sie den zu übersetzenden Inhalt ein'),
  LanguageBean(
      code: 'ja',
      name: 'Japanese',
      native: t.translate.language_native_ja,
      hint: '翻訳する内容を入力してください'),
  LanguageBean(
      code: 'ko',
      name: 'Korean',
      native: t.translate.language_native_ko,
      hint: '번역할 내용을 입력하세요.')
];

final targetLanguage = [
  LanguageBean(
      code: 'zh',
      name: 'Chinese',
      native: t.translate.language_native_zh,
      hint: '请输入待翻译内容'),
  LanguageBean(
      code: 'ru',
      name: 'Russian',
      native: t.translate.language_native_ru,
      hint: 'Пожалуйста, введите текст для перевода'),
  LanguageBean(
      code: 'en',
      name: 'English',
      native: t.translate.language_native_en,
      checked: true,
      hint: 'Please enter the content to be translated'),
  LanguageBean(
      code: 'fr',
      name: 'French',
      native: t.translate.language_native_fr,
      hint: 'Veuillez entrer le contenu à traduire'),
  LanguageBean(
      code: 'de',
      name: 'German',
      native: t.translate.language_native_de,
      hint: 'Bitte geben Sie den zu übersetzenden Inhalt ein'),
  LanguageBean(
      code: 'ja',
      name: 'Japanese',
      native: t.translate.language_native_ja,
      hint: '翻訳する内容を入力してください'),
  LanguageBean(
      code: 'ko',
      name: 'Korean',
      native: t.translate.language_native_ko,
      hint: '번역할 내용을 입력하세요.')
];

///
/// 翻译按钮[FloatingActionButton]
///
Widget createTranslateButton(BuildContext context, VoidCallback onPress) {
  return FloatingActionButton.extended(
    onPressed: () => onPress(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    label: Text(t.translate.translate_start, style: style20),
    icon: const Icon(Icons.translate),
  );
}

///
/// 语言切换菜单[MenuAnchor]
///
Widget languageMenu(
  String code,
  String native,
  List<LanguageBean> list,
  MenuController menuController,
  VoidCallback onTap,
  Function(LanguageBean) onClick,
) {
  return MenuAnchor(
      controller: menuController,
      style: MenuStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      builder: (_, MenuController controller, __) {
        return InkWell(
            borderRadius: BorderRadius.circular(26),
            onTap: () => onTap(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 20,
                      child: Text(code, style: style20)),
                  const SizedBox(width: 16),
                  Text(native, style: style20),
                  const SizedBox(width: 16),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down, size: 24),
                  const SizedBox(width: 8)
                ]));
      },
      menuChildren: menuList(list, onClick));
}

///
/// 语言菜单列表[MenuAnchor menuChildren content]
///
List<Widget> menuList(List<LanguageBean> list, Function(LanguageBean) onTap) {
  final menuList = <Widget>[];
  for (final bean in list) {
    menuList.add(SizedBox(
        width: 152,
        child: ListTile(
            trailing: (bean.checked ?? false)
                ? const Icon(Icons.check_outlined)
                : null,
            selected: bean.checked ?? false,
            onTap: () => onTap(bean),
            title: Text(bean.native ?? '', style: style15))));
  }
  return menuList;
}

///
/// 创建切换语言按钮[IconButton-Change language]
///
Widget createChangeLanguageButton(BuildContext context, VoidCallback onPress) {
  return IconButton(
    padding: EdgeInsets.zero,
    color: Theme.of(context).colorScheme.onTertiaryContainer,
    onPressed: () => onPress(),
    icon: const Icon(Icons.swap_horiz_outlined, size: 24),
  );
}

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/document/provider/doc_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/utils/sp_provider.dart';

///
/// 文档问答属性配置[prepared doc setting]
///
class DocSetting extends ConsumerWidget {
  const DocSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(docPromptModelProvider);
    return Container(
        width: 268,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: const EdgeInsets.only(bottom: 24, top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 0.2),
            color: Theme.of(context).navigationDrawerTheme.surfaceTintColor),
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 16),
          Container(
              alignment: Alignment.center,
              child: FloatingActionButton.extended(
                elevation: 0,
                extendedPadding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                icon: const Icon(Icons.settings_suggest,
                    size: 28, color: Color(0xFF49454F)),
                label: Text(t.document.doc_setting,
                    style: const TextStyle(
                        fontSize: 18, color: Color(0xFF49454F))),
                onPressed: () {},
              )),
          const SizedBox(height: 16),
          radioTile(ref, context, t.document.doc_setting_one,
              t.document.doc_setting_one_tip, selectedValue, 1),
          const SizedBox(height: 16),
          radioTile(ref, context, t.document.doc_setting_two,
              t.document.doc_setting_two_tip, selectedValue, 2),
          const SizedBox(height: 16),
          radioTile(ref, context, t.document.doc_setting_three,
              t.document.doc_setting_three_tip, selectedValue, 3),
        ])));
  }

  ///
  /// 更新文档属性配置缓存[update doc setting cache]
  ///
  handleSelectedValue(WidgetRef ref, int? val) {
    if (val == null) return;
    ref.read(docPromptModelProvider.notifier).update((state) => val);
    SpProvider().setInt("promptModel", val);
  }

  ///
  /// doc setting radio tile
  ///
  Widget radioTile(
    WidgetRef ref,
    BuildContext context,
    String content,
    String tooltip,
    int? selectedValue,
    int value,
  ) {
    return RadioListTile(
      value: value,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(48))),
      contentPadding: const EdgeInsets.only(left: 0, right: 0),
      groupValue: selectedValue,
      toggleable: true,
      activeColor: Theme.of(context).colorScheme.primary,
      title: Text(content),
      onChanged: (val) => handleSelectedValue(ref, val),
      secondary: IconButton(
        icon: const Icon(Icons.info_outline, size: 20),
        onPressed: () {},
        tooltip: tooltip,
      ),
      selected: selectedValue == 1,
    );
  }
}

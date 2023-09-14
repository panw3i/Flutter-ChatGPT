import 'package:flutter/material.dart';
import 'package:frontend/pages/translate/view/translate_language.dart';
import 'package:frontend/pages/translate/view/ui_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/translate/view/translate_generate.dart';
import 'package:frontend/pages/translate/view/translate_input.dart';
import 'package:frontend/pages/translate/view/translate_message.dart';

///
/// AI-Translate
///
class TranslatePage extends ConsumerStatefulWidget {
  const TranslatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TranslatePageState();
  }
}

class TranslatePageState extends ConsumerState<TranslatePage>
    with AutomaticKeepAliveClientMixin {
  late final inputControl = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 选择语言Card[TranslateLanguage]
              TranslateLanguage(inputControl, inputLanguage, targetLanguage),
              Expanded(
                child: Row(children: [
                  /// 用户输入待翻译文本[input content]
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 180, maxWidth: 472),
                    margin:
                        const EdgeInsets.only(left: 36, top: 16, bottom: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        width: 1,
                      ),
                    ),
                    child: TranslateInput(inputControl, inputLanguage),
                  ),
                  const SizedBox(width: 48),

                  /// AI-Bot翻译文本[AI Translate]
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 180, maxWidth: 472),
                    margin:
                        const EdgeInsets.only(right: 36, top: 16, bottom: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        // color: Colors.grey[100],
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: const Color(0xFFF5F5F5), width: 1)),
                    child: TranslateMessage(),
                  )
                ]),
              ),
              const SizedBox(height: 16),

              /// 请求翻译[request translate]
              TranslateGenerate(inputControl, inputLanguage, targetLanguage),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/pages/translate/provider/translate_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 翻译输入文本 AI-bot
///
translateBotMessage(
    String inputType, String targetType, String inputStr, WidgetRef ref) {
  final message =
      'Translate the following $inputType text to $targetType: $inputStr';
  ref.read(translateInputProvider.notifier).update((state) => {true: message});
}

///
/// 显示用户输入待翻译内容[show user input content]
///
translateUserMessage(WidgetRef ref, String inputStr) {
  ref
      .read(translateInputProvider.notifier)
      .update((state) => {false: inputStr});
}

///
/// 切换语言选择[change language]
///
updateLanguage(WidgetRef ref) {
  ref
      .read(updateLanguageProvider.notifier)
      .update((state) => Random().nextDouble());
}

///
/// 创建Stream[translate content and received stream]
///
Stream<String>? stream(WidgetRef ref, String message) {
  return ref.read(translateStateProvider.notifier).sendMessageStreamApi(message,
      () {
    ref.read(showGenerateProvider.notifier).update((state) => true);
  }, () {
    ref.read(showGenerateProvider.notifier).update((state) => false);
  });
}

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/routers.dart';
import 'package:frontend/theme/color_schemes.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///
/// Application
///
class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        routerConfig: globalRouter,
        themeMode: ThemeMode.light,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        title: t.app.name,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        debugShowCheckedModeBanner: false);
  }
}

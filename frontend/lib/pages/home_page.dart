import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/routers.dart';
import 'package:frontend/pages/drawer/navigation_drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

///
/// Main Container
///
class HomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomePage(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: NavigationDrawerWidget(navigationShell),
        appBar: AppBar(
            leadingWidth: 68,
            titleSpacing: 0,
            leading: IconButton(
              tooltip: 'Open Drawer Menu',
              padding: const EdgeInsets.all(8),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
              icon: const Icon(Icons.menu),
            ),
            centerTitle: false,
            title: MenuTitle(navigationShell.currentIndex),
            actions: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: AnimatedTextKit(animatedTexts: [
                    WavyAnimatedText(t.home.appbar_action,
                        textStyle: style16)
                  ], repeatForever: true)),
            ]),
        body: navigationShell);
  }
}

///Menu Name
class MenuTitle extends ConsumerWidget {
  const MenuTitle(this.currentIndex, {super.key});

  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(menuNameList[currentIndex]);
  }
}

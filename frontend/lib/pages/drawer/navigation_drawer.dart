import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/routers.dart';

///
/// Navigation Drawer Menu
///
class NavigationDrawerWidget extends ConsumerStatefulWidget {
  const NavigationDrawerWidget(this.navigationShell, {Key? key})
      : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return NavigationDrawerWidgetState();
  }
}

class NavigationDrawerWidgetState
    extends ConsumerState<NavigationDrawerWidget> {
  final drawerContent = <Widget>[];

  final menuIconList = [
    Icons.mark_unread_chat_alt,
    Icons.translate,
    Icons.edit_document,
    Icons.document_scanner,
    Icons.task_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        onDestinationSelected: (index) {
          scaffoldKey.currentState!.closeDrawer();
          widget.navigationShell.goBranch(index);
        },
        selectedIndex: widget.navigationShell.currentIndex,
        children: createContent());
  }

  ///
  /// drawer header
  ///
  Widget createHeader() {
    return Container(
        height: 80,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16, top: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(8),
                    mouseCursor: SystemMouseCursors.click,
                    tooltip: 'Close Drawer Menu',
                    onPressed: () => scaffoldKey.currentState!.closeDrawer(),
                    icon: const Icon(Icons.menu)),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 4),
                  Text('Flutter-ChatGPT', style: textStyle),
                  const SizedBox(height: 4),
                  Text(t.home.drawer_subtitle)
                ])
              ])
        ]));
  }

  ///
  /// drawer content
  ///
  List<Widget> createContent() {
    drawerContent.clear();
    drawerContent.add(createHeader());
    for (var i = 0; i < menuNameList.length; i++) {
      var menu = NavigationDrawerDestination(
          icon: Icon(menuIconList[i]), label: Text(menuNameList[i]));
      drawerContent.add(menu);
    }
    return drawerContent;
  }

  TextStyle? get textStyle => Theme.of(context)
      .textTheme
      .titleLarge
      ?.copyWith(fontWeight: FontWeight.w500);
}

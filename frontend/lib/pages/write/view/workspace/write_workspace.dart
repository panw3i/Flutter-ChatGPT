import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';

///
/// Write Workspace[Prompt Template - Generative Text]
///
class WriteWorkspace extends ConsumerStatefulWidget {
  const WriteWorkspace({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WriteWorkspaceState();
  }
}

class WriteWorkspaceState extends ConsumerState<WriteWorkspace>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final index = ref.watch(writeWorkspaceProvider);
    return Container(
        margin: const EdgeInsets.only(top: 12, bottom: 20),
        child: NavigationRail(
          onDestinationSelected: (int index) {
            ref.read(writeWorkspaceProvider.notifier).update((state) => index);
          },
          selectedIndex: index,
          leading: SizedBox(
              width: 220,
              child: FloatingActionButton.extended(
                onPressed: () {},
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                icon: const Icon(Icons.edit_document),
                label: Text('  ${t.write.workspace}', style: style18),
              )),
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                  onPressed: () {},
                  tooltip: 'Generative AI',
                  icon: Image.asset('assets/images/ic_bot_workspace.png',
                      width: 56, height: 56)),
            ),
          ),
          extended: true,
          destinations: [
            NavigationRailDestination(
              padding: const EdgeInsets.only(top: 32, bottom: 12, left: 12),
              icon: const Icon(Icons.home),
              label: Text(t.write.prompt_space, style: style16),
            ),
            NavigationRailDestination(
              padding: const EdgeInsets.only(left: 12),
              icon: const Icon(Icons.generating_tokens_outlined),
              label: Text(t.write.generate_content, style: style16),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

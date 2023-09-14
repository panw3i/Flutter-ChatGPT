import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/write/provider/write_provider.dart';
import 'package:frontend/pages/write/view/generate/write_generate.dart';
import 'package:frontend/pages/write/view/prompt/write_prompt.dart';
import 'package:frontend/pages/write/view/workspace/write_workspace.dart';

///
/// 智能创作[AI-Write]
///
class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WritePageState();
  }
}

class WritePageState extends ConsumerState<WritePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      currentPageIndex = _tabController.index;
      ref
          .read(writeWorkspaceProvider.notifier)
          .update((state) => currentPageIndex);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(writeWorkspaceProvider, (previous, next) {
      if (currentPageIndex == next) return;
      _tabController.animateTo(next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.slowMiddle);
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const WriteWorkspace(),
          SizedBox(
            width: 1024,
            child: TabBarView(
                controller: _tabController,
                children: const [WritePrompt(), WriteGenerate()]),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/pages/write/view/generate/generate_bot.dart';
import 'package:frontend/utils/style_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/write/view/generate/write_template.dart';

///
/// 文本生成页面[Generate Content Widget]
///
class WriteGenerate extends ConsumerStatefulWidget {
  const WriteGenerate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return WriteGenerateState();
  }
}

class WriteGenerateState extends ConsumerState<WriteGenerate>
    with AutomaticKeepAliveClientMixin {
  //生成内容滚动控制
  final ScrollController _listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 1024),
      margin: const EdgeInsets.only(top: 20, bottom: 16, left: 32),
      child: Row(children: [
        /// 左侧问题模版[left template]
        GenerateTemplate(),

        /// 右侧内容生成 [right generate content]
        Expanded(
          child: Card(
            elevation: 1,
            child: Column(
              children: [
                const SizedBox(height: 32),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.generating_tokens),
                    label: Text(t.write.generate_content_ai, style: style18)),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                      controller: _listScrollController,
                      children: [GenerateBotView(_listScrollController)]),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

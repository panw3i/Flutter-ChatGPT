# Flutter-ChatGPT

基于Flutter Web实现ChatGPT多轮聊天、翻译、Prompt文本生成、企业知识库、本地文档问答、functions_call等功能,页面流式输出采用StreamBuilder
Widget实现，各业务模块Repository均提供直连OpenAI接口与python后端API接口流式输出功能实例

## backend

采用FastApi实现后端LangChain调用OpenAI接口
> backend-data

- 提供初始化向量文档，构建向量索引代码位于[vector_index.py](backend%2Fservice%2Fvector_index.py)

> backend-service

- [function_call.py](backend%2Fservice%2Ffunction_call.py)
  提供openai function call相关实例功能
- [model_query.py](backend%2Fservice%2Fmodel_query.py)
  提供python方法调用参数封装模型，涉及文档问答与多轮对话
- [vector_index.py](backend%2Fservice%2Fvector_index.py)
  提供本地知识库/上传文档向量化相关实例功能

> backend-env

提供设置OpenAI参数设置[OPENAI_API_KEY]

```
# openai
openai.log = "debug"
openai.api_key = os.environ["OPENAI_API_KEY"]
```

> backend-main.py

提供FastApi接口功能实例，包括response stream流处理

> backend-requirments.txt

依赖组件配置，可通过terminal执行

```
pip install -r requirments.txt
```

## frontend

采用Flutter实现Web-UI（Material3）功能，具体功能可查看[screenshot](screenshot)
> frontend-db

web浏览器IndexedDB数据库操作与模型实例

> frontend-pages

业务功能模块，包含以下内容：

1. 智能对话
2. 智能翻译
3. 智能写作
4. 智能文档
5. 智能任务

各模块遵循repository-model-provider-view分包方式，其中各view模块按功能复杂度拆分widgets与states，
具体拆分粒度按实际业务要求处理，尽可能执行局部刷新，通过[go_router][StatefulShellBranch]实现各页面路由状态管理，
页面逐字打印采用SteamBuild
Widget实现，具体代码如下[message_bot.dart](frontend%2Flib%2Fpages%2Fmessage%2Fmessage_bot.dart)：

```
///
/// 流式请求[request task stream message]
///
Stream<String>? stream(WidgetRef ref, bool mounted) {
  return
      //ref.read(taskStateProvider.notifier).sendMessageStream('', '', () {
      ref.read(taskStateProvider.notifier).sendMessageStreamApi('', '', () {
    if (!mounted) return;
    ref.read(allowInputTaskProvider.notifier).update((state) => false);
  }, () {
    if (!mounted) return;
    ref.read(allowInputTaskProvider.notifier).update((state) => true);
  });
}

///
/// StreamBuilder
///
class MessageBotStream extends ConsumerWidget {
  const MessageBotStream(this.stream, this.controller, {super.key});

  final Stream<String>? stream;

  //滚动控制
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: stream,
      key: Key('${Random().nextDouble()}'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text("${t.app.error}: ${snapshot.error}");
        }
        if (snapshot.hasData) {
          String content = snapshot.data ?? "";
          scrollEnd(controller, 200);
          if (content.isNotEmpty) return Text(content);
        }
        return const MessageLoading();
      },
    );
  }
}
```

> frontend-assets

提供业务模块使用图标与i18n国际化语言配置，slang国际化内容生成[gen](frontend%2Flib%2Fgen)

## 演示效果截图

[screenshot](screenshot)

![AI-Chat-01.png](screenshot%2Fzh%2FAI-Chat-01.png)

![AI-Translate-01.png](screenshot%2Fzh%2FAI-Translate-01.png)

![AI-Write-01.png](screenshot%2Fzh%2FAI-Write-01.png)

![AI-Document-01.png](screenshot%2Fzh%2FAI-Document-01.png)

![AI-Task-01.png](screenshot%2Fzh%2FAI-Task-01.png)

![Drawer-Menu-01.png](screenshot%2Fzh%2FDrawer-Menu-01.png)

## 引用pub flutter库(https://pub.dev/)

Flutter SDK version: 3.13.2 (stable)

Dart SDK version: 3.1.0 (stable)

> animated_text_kit: ^4.2.2

> flutter_spinkit: ^5.2.0

> go_router: ^10.1.2

> hooks_riverpod: ^2.3.10

> logger: ^2.0.1

> shared_preferences: ^2.2.1

> sembast_web: ^2.1.3

> http: ^1.1.0

> file_picker: ^5.5.0

> slang: ^3.23.0

> slang_flutter: ^3.23.0
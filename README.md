# Flutter-ChatGPT

中文文档地址[README_zh.md](README_zh.md)

Based on Flutter Web to realize ChatGPT multi-round chat, translation, Prompt text generation,
enterprise knowledge base, local document Q&A, functions_call and so on.Page streaming output using
StreamBuilder Widget implementation, each business module Repository are provided directly connected
to the OpenAI interface and python back-end API interface streaming output function examples

## backend

Using FastApi to implement the back-end LangChain to call OpenAI interface
> backend-data

- Provides initialization of vector documents, construction of vector index code is located in
  the[vector_index.py](backend%2Fservice%2Fvector_index.py)

> backend-service

- [function_call.py](backend%2Fservice%2Ffunction_call.py)
  Provide openai function call related example functions
- [model_query.py](backend%2Fservice%2Fmodel_query.py)
  Provide python method invocation parameter encapsulation model, involving document Q&A and
  multi-round dialogs
- [vector_index.py](backend%2Fservice%2Fvector_index.py)
  Provide local knowledge base/upload document vectorization related example functions

> backend-env

Provide OpenAI parameter settings[OPENAI_API_KEY]

```
# openai
openai.log = "debug"
openai.api_key = os.environ["OPENAI_API_KEY"]
```

> backend-main.py

Provide examples of FastApi interface functionality, including response stream processing.

> backend-requirments.txt

Component-dependent configuration, executable via terminal

```
pip install -r requirments.txt
```

## frontend

Web-UI (Material3) functionality using Flutter, check out the specific features
of[screenshot](screenshot)
> frontend-db

Web Browser IndexedDB Database Operation and Modeling Examples

> frontend-pages

Business modules，contains following：

1. AI-Conversation
2. AI-Translate
3. AI-Write
4. AI-Document
5. AI-Task

The modules follow [repository-model-provider-view]package structure，The view modules are split into
widgets and states by functional complexity，
Specific splitting granularity is handled according to actual business requirements, and local
refreshes are performed whenever possible，through[go_router][StatefulShellBranch]realize the
management of the routing state of each page. Pages are printed verbatim using SteamBuilder
Widget realized，The specific code is as follows

[message_bot.dart](frontend%2Flib%2Fpages%2Fmessage%2Fmessage_bot.dart)：

```
///
/// [request task stream message]
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

Provide business modules using icons and i18n internationalization language configuration, slang
internationalization content generation

[i18n gen](frontend%2Flib%2Fgen)

## Demo Screenshot

[screenshot](screenshot)

![AI-Chat-01.png](screenshot%2Fen%2FAI-Chat-01.png)

![AI-Translate-01.png](screenshot%2Fen%2FAI-Translate-01.png)

![AI-Write-01.png](screenshot%2Fen%2FAI-Write-01.png)

![AI-Document-01.png](screenshot%2Fen%2FAI-Document-01.png)

![AI-Task-01.png](screenshot%2Fen%2FAI-Task-01.png)

![Drawer-Menu-01.png](screenshot%2Fen%2FDrawer-Menu-01.png)

## Quote Pub Flutter(https://pub.dev/)

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

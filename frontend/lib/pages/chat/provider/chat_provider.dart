import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/db/app_database.dart';
import 'package:frontend/pages/chat/model/chat_selected.dart';
import 'package:frontend/pages/chat/repository/chat_repository.dart';
import 'package:logger/logger.dart';
import 'package:sembast/sembast.dart';

///输入问题-发送信息[send message action]
final sendMessageProvider = StateProvider.autoDispose<double>((ref) => 0);

///是否允许输入[allow input]
final allowInputProvider = StateProvider.autoDispose<bool>((ref) => true);

///当前选中对话对象[current selected model]
final chatSelectedProvider =
    StateProvider.autoDispose<ChatSelected>((ref) => ChatSelected());

/// 是否显示加载
final showProgressProvider = StateProvider.autoDispose<bool>((ref) => false);

///
/// conversationProvider
/// 聊天模块StateNotifierProvider
///
final conversationProvider = StateNotifierProvider.autoDispose<
    ConversationStateNotifier, ConversationState>((ref) {
  return ConversationStateNotifier();
});

///
/// state
///
class ConversationState {
  /// 对话列表[Conversation list]
  List<Conversations>? conversations;

  /// 单个对话消息数据[Single Conversation Messages]
  List<Messages>? messages;

  ConversationState({this.conversations, this.messages});
}

///
/// notifier
///
class ConversationStateNotifier extends StateNotifier<ConversationState> {
  ConversationStateNotifier() : super(ConversationState());

  Future<Database> get _db async => await AppDatabase.instance.database;

  /// 存储对话[store conversation]
  final _conversations = intMapStoreFactory.store('conversations');

  /// 存储消息[store message]
  final _messages = intMapStoreFactory.store('messages');

  ///
  /// 校验是否存在默认对话
  /// [check conversation list by default]
  ///
  Future<bool> checkConversationList() async {
    final recordSnapshots = await _conversations.find(await _db);
    return Future(() => recordSnapshots.isNotEmpty);
  }

  ///
  /// 查询所有对话列表
  /// [query conversation list]
  ///
  void queryConversationList() async {
    final recordSnapshots = await _conversations.find(await _db);
    final list = recordSnapshots.map((snapshot) {
      final conversations = Conversations.fromJson(snapshot.value);
      conversations.id = snapshot.key;
      return conversations;
    }).toList();
    state = ConversationState(conversations: list, messages: state.messages);
  }

  ///
  /// 查询所有对话列表-直接返回结果，用于新增切换
  /// [query conversation list->return results directly,used for new select]
  ///
  Future<List<Conversations>> queryConversationListSelected() async {
    final recordSnapshots = await _conversations.find(await _db);
    final list = recordSnapshots.map((snapshot) {
      final conversations = Conversations.fromJson(snapshot.value);
      conversations.id = snapshot.key;
      return conversations;
    }).toList();
    return list;
  }

  ///
  /// 根据id查询所有对话消息
  /// [query conversation messages by id]
  ///
  Future queryMessagesWithId(num? id) async {
    final recordSnapshots = await _messages.find(await _db);
    final list = recordSnapshots
        .map((snapshot) => Messages.fromJson(snapshot.value))
        .where((element) => element.id == id)
        .toList();
    state =
        ConversationState(conversations: state.conversations, messages: list);
    return list;
  }

  ///
  /// 新增对话
  /// [add conversation]
  ///
  Future<int> addConversation() async {
    final conversation = Conversations(title: t.chat.create_chat_title);
    return await _conversations.add(await _db, conversation.toJson());
  }

  ///
  /// 新增对话,包含主题名称
  /// [add conversation，contains title]
  ///
  Future<int> addConversationPrompt(String title) async {
    final conversation = Conversations(title: title);
    return await _conversations.add(await _db, conversation.toJson());
  }

  ///
  /// 更新对话中的messages
  /// [update conversation messages]
  ///
  Future<int> updateConversationMessage(num? id, String msg, bool user) async {
    final recordSnapshots = await _messages.find(await _db,
        finder: Finder(filter: Filter.byKey(id)));
    final recordList = <Messages>[];
    for (var element in recordSnapshots) {
      if (element.key == id) {
        var data = Messages.fromJson(element.value);
        recordList.add(data);
      }
    }
    if (recordList.isEmpty) return 0;
    recordList.add(
        Messages(message: msg, time: DateTime.now().toString(), isUser: user));
    return await _messages.add(await _db, recordList as Map<String, Object?>);
  }

  ///
  /// 新增对话中的messages
  /// [add conversation messages]
  ///
  Future<int> addMessages(num? id, String msg, bool user) async {
    final messages = Messages(
        id: id, message: msg, time: DateTime.now().toString(), isUser: user);
    return await _messages.add(await _db, messages.toJson());
  }

  ///
  /// 新增对话中的默认messages
  /// [add default conversation messages]
  ///
  Future<int> addDefaultMessages(num? id) async {
    final messages = Messages(
        id: id,
        message: t.chat.default_tip,
        time: DateTime.now().toString(),
        isUser: false);
    return await _messages.add(await _db, messages.toJson());
  }

  ///
  /// 新增对话中的默认messages
  ///
  Future<int> addPromptMessages(num? id, String promptContent) async {
    final messages = Messages(
        id: id,
        message: promptContent,
        time: DateTime.now().toString(),
        isUser: false);
    return await _messages.add(await _db, messages.toJson());
  }

  ///
  /// 修改对话title
  ///
  Future<int> updateConversationTitle(num? id, String title) async {
    //根据id查询对话
    final recordSnapshots = await _conversations.find(await _db,
        finder: Finder(filter: Filter.byKey(id)));
    //解析数据
    final list = recordSnapshots.map((snapshot) {
      return Conversations.fromJson(snapshot.value);
    }).toList();
    //赋值title
    final data = list[0]..title = title;
    return await _conversations.update(await _db, data.toJson(),
        finder: Finder(filter: Filter.byKey(id)));
  }

  ///
  /// 根据对话id删除
  ///
  Future<int> deleteConversations(num? id) async {
    deleteMessages(id);
    return await _conversations.delete(await _db,
        finder: Finder(filter: Filter.byKey(id)));
  }

  ///
  /// 根据对话id删除message
  ///
  Future<int> deleteMessages(num? id) async {
    // return await _messages.delete(await _db,
    //     finder: Finder(filter: Filter.byKey(id)));
    return await _messages.delete(await _db,
        finder: Finder(filter: Filter.custom((snapshot) {
      final message = Messages.fromJson(snapshot.value);
      return message.id == id;
    })));
  }

  ///
  /// 直接请求ChatGPT API发送消息
  /// [send message with openai api]
  ///
  Stream<String> sendMessageStream(num? id, List<Messages>? messages,
      Function waiting, Function finish) async* {
    if (messages == null || messages.isEmpty || messages.last.isUser == false) {
      addMessages(id, t.app.error, false)
          .then((value) => queryMessagesWithId(id));
      return;
    }
    waiting();
    final lastMessage = messages.last;
    String showContent = "";
    try {
      final stream = await ChatRepository.instance
          .sendMessageStream(lastMessage.message ?? "", messages);
      // .sendMessageStreamApi(lastMessage.message ?? "");
      await for (final chunk in stream) {
        debugPrint("receive stream = $chunk");
        final dataLines =
            chunk.split("\n").where((element) => element.isNotEmpty).toList();
        Logger().d("dataLines ---- $dataLines");
        for (final line in dataLines) {
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6);
          Logger().d("substring ---- $data");
          if (data == "[DONE]") {
            Logger().d('data receive finished，data.[DONE]');
            break;
          }
          Map<String, dynamic> responseData = json.decode(data);
          Logger().d("Response ---- $responseData");
          List<dynamic> choices = responseData["choices"];
          Map<String, dynamic> choice = choices[0];
          Map<String, dynamic> delta = choice["delta"];
          String content = delta["content"] ?? "";
          showContent += content;
          Logger().d("current content ---- $showContent");
          yield showContent;
          String finishReason = choice["finish_reason"] ?? "";
          if (finishReason.isNotEmpty) {
            Logger().d("finish_reason：$finishReason");
            break;
          }
          await Future.delayed(const Duration(milliseconds: 16));
        }
      }
    } catch (e) {
      yield showContent;
      Logger().d('stream receive error， $e');
      //addMessages(id, t.app.error, false).then((value) => queryMessagesWithId(id));
    } finally {
      yield showContent;
      Logger().d('stream receive finished，$showContent');
      addMessages(id, showContent.isEmpty ? t.app.error : showContent, false)
          .then((value) => queryMessagesWithId(id));
      finish();
    }
  }

  ///
  /// 请求python服务API发送消息
  /// [send message with python api]
  ///
  Stream<String> sendMessageStreamApi(num? id, List<Messages>? messages,
      Function waiting, Function finish) async* {
    if (messages == null || messages.isEmpty || messages.last.isUser == false) {
      addMessages(id, t.app.error, false)
          .then((value) => queryMessagesWithId(id));
      return;
    }
    waiting();
    final lastMessage = messages.last;
    String showContent = "";
    try {
      debugPrint("start stream = ${DateTime.now()}");
      final stream = await ChatRepository.instance
          .sendMessageStreamApi(lastMessage.message ?? "");
      debugPrint("end stream = ${DateTime.now()}");
      await for (final chunk in stream) {
        debugPrint("received stream =$chunk");
        final dataLines =
            chunk.split("\n").where((element) => element.isNotEmpty).toList();
        for (final line in dataLines) {
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6).isEmpty ? "\n" : line.substring(6);
          if (showContent.endsWith('\n') && data == '\n') continue;
          showContent += data;
          yield showContent;
          await Future.delayed(const Duration(milliseconds: 16));
        }
      }
    } catch (e) {
      yield showContent;
      debugPrint('received error $e');
      // addMessages(id, t.app.error, false).then((value) => queryMessagesWithId(id));
    }
    yield showContent;
    finish();
    addMessages(id, showContent.isEmpty ? t.app.error : showContent, false)
        .then((value) => queryMessagesWithId(id));
  }

  ///
  /// 测试Stream流式返回
  /// [Test stream returning]
  ///
  Stream<String> getTextStream(
      num? id, Function waiting, Function finish) async* {
    String content = '';
    waiting();
    final text = t.app.big_text;
    await Future.delayed(const Duration(milliseconds: 5000));
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 16));
      yield content += text.substring(i, i + 1);
    }
    finish();
    await addMessages(id, content, false);
    queryMessagesWithId(id);
  }
}

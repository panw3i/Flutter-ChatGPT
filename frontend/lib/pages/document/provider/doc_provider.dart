import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/db/app_database.dart';
import 'package:frontend/pages/document/model/doc_selected.dart';
import 'package:frontend/pages/document/repository/doc_repository.dart';
import 'package:frontend/utils/sp_provider.dart';
import 'package:logger/logger.dart';
import 'package:sembast/sembast.dart';

/// 接口请求模型区分[doc prompt setting model]
final docPromptModelProvider = StateProvider.autoDispose<int>((ref) => 1);

/// 输入问题-发送信息[doc message send state action]
final sendMessageDocProvider = StateProvider.autoDispose<double>((ref) => 0);

/// 是否允许输入[doc text field allow input]
final allowInputDocProvider = StateProvider.autoDispose<bool>((ref) => true);

///
/// conversationDocProvider
///
final conversationDocProvider = StateNotifierProvider.autoDispose<
    ConversationStateNotifier, ConversationState>((ref) {
  return ConversationStateNotifier();
});

/// 选中文档对话[doc conversation selected]
final chatSelectedDocProvider =
    StateProvider.autoDispose<DocSelected>((ref) => DocSelected());

/// state
class ConversationState {
  /// 对话列表[doc conversation list]
  List<Conversations>? conversations;

  /// 单个对话消息数据[doc single conversation messages]
  List<Messages>? messages;

  int status = -1;
  String tips = '';

  ConversationState(
      {this.conversations, this.messages, this.status = -1, this.tips = ''});
}

///
/// notifier
///
class ConversationStateNotifier extends StateNotifier<ConversationState> {
  ConversationStateNotifier() : super(ConversationState());

  Future<Database> get _db async => await AppDatabase.instance.database;

  /// 存储对话[doc store conversation]
  final _conversations = intMapStoreFactory.store('conversations_doc');

  /// 存储消息[doc store message]
  final _messages = intMapStoreFactory.store('messages_doc');

  /// 校验是否存在默认对话[doc check conversation list by default]
  Future<bool> checkConversationList() async {
    final recordSnapshots = await _conversations.find(await _db);
    return Future(() => recordSnapshots.isNotEmpty);
  }

  ///
  /// 查询所有对话列表
  /// [doc query conversation list]
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
  /// [doc query conversation list->return results directly,used for new select]
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
  /// [doc query conversation messages by id]
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
  /// [doc add conversation with file name]
  ///
  Future<int> addConversationName(String name) async {
    final conversation = Conversations(title: name);
    return await _conversations.add(await _db, conversation.toJson());
  }

  ///
  /// 修改对话中的messages
  /// [doc update conversation message]
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
  /// [doc add conversation messages]
  ///
  Future<int> addMessages(num? id, String msg, bool user) async {
    final messages = Messages(
        id: id, message: msg, time: DateTime.now().toString(), isUser: user);
    return await _messages.add(await _db, messages.toJson());
  }

  ///
  /// 新增对话中的默认messages
  /// [doc add default conversation messages]
  ///
  Future<int> addDefaultMessages(num? id, {bool localTip = false}) async {
    final messages = Messages(
        id: id,
        message: t.document.default_tip,
        time: DateTime.now().toString(),
        isUser: false);
    return await _messages.add(await _db, messages.toJson());
  }

  ///
  /// 根据对话id删除
  /// [doc delete conversation with id]
  ///
  Future<int> deleteConversations(num? id) async {
    deleteMessages(id);
    return await _conversations.delete(await _db,
        finder: Finder(filter: Filter.byKey(id)));
  }

  ///
  /// 根据对话id删除message
  /// [doc delete conversation message with conversation_id]
  ///
  Future<int> deleteMessages(num? id) async {
    return await _messages.delete(await _db,
        finder: Finder(filter: Filter.custom((snapshot) {
      final message = Messages.fromJson(snapshot.value);
      return message.id == id;
    })));
  }

  ///
  /// 发送消息
  /// [doc send message]
  ///
  Stream<String> sendMessageStream(num? id, List<Messages>? messages,
      String fileName, Function waiting, Function finish) async* {
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
      final queryType = SpProvider().getInt("promptModel");
      final stream = await DocRepository.instance
          .sendMessageStream(lastMessage.message ?? "", queryType, fileName);
      debugPrint("end stream = ${DateTime.now()}");
      await for (final chunk in stream) {
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
      debugPrint('stream received error $e');
      addMessages(id, t.app.error, false)
          .then((value) => queryMessagesWithId(id));
    }
    yield showContent;
    finish();
    addMessages(id, showContent.isEmpty ? t.app.error : showContent, false)
        .then((value) => queryMessagesWithId(id));
  }

  ///
  /// 获取向量化文件列表
  /// [get vector file list]
  ///
  Future<List<String>> getVectorFileList() async {
    try {
      final docDefaultFile = await DocRepository.instance.getVectorFileList();
      return docDefaultFile.result ?? [];
    } catch (e) {
      Logger().d('error occurs $e');
    }
    return [];
  }

  ///
  /// 上传文件
  /// [upload file]
  ///
  Future<String> uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          withData: true,
          type: FileType.custom, //PDF·DOCX·TXT·EXCEL·PPT·MD
          allowedExtensions: ['pdf', 'docx', 'txt', 'ppt', 'md']);
      if (result != null) {
        state = ConversationState(
            conversations: state.conversations,
            messages: state.messages,
            status: 0,
            tips: t.document.uploading);
        final fileName = result.files.first.name;
        List<Conversations> list = await queryConversationListSelected();
        final size = list.where((element) => element.title == fileName).length;
        if (size != 0) {
          state = ConversationState(
              conversations: state.conversations,
              messages: state.messages,
              status: 2,
              tips: t.document.upload_failure);
          return '';
        }
        final queryType = SpProvider().getInt("promptModel");
        await DocRepository.instance
            .uploadFile(queryType, '', result.files.first, (data) {
          final code = data['code'];
          final msg = data['msg'];
          if (code != 0) {
            state = ConversationState(
                conversations: state.conversations,
                messages: state.messages,
                status: 2,
                tips: msg);
            return '';
          }
          state = ConversationState(
              conversations: state.conversations,
              messages: state.messages,
              status: 1,
              tips: msg);
          return result.files.first.name;
        });
      }
    } catch (e) {
      Logger().d('upload file error $e');
      state = ConversationState(
          conversations: state.conversations,
          messages: state.messages,
          status: 2,
          tips: t.document.upload_error);
    }
    return '';
  }
}

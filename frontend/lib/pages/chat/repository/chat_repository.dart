import 'dart:convert';

import 'package:frontend/db/conversation_message.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:frontend/utils/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ChatRepository {
  static final ChatRepository _singleton = ChatRepository._();

  static ChatRepository get instance => _singleton;

  ChatRepository._();

  ///
  /// 多轮对话,直接请求ChatGPT API
  /// Multiple conversations , directly request to ChatGPT API
  ///
  Future<Stream<String>> sendMessageStream(
      String userMessage, List<Messages> msgList) async {
    var url = Uri.https('api.openai.com', 'v1/chat/completions');
    var request = http.Request('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${ApiProvider.aiApiKey}',
      'Content-Type': 'application/json; charset=UTF-8'
    });
    List<Map<String, dynamic>> messages = [];
    for (var i = 0; i < msgList.length; i++) {
      final data = msgList[i];
      final isCheck = data.message?.contains(t.app.error) == true;
      if (isCheck) continue;
      String content = data.message ?? '';
      if (i != msgList.length - 1 && content.length > 200) {
        content = content.substring(0, 200);
      }
      messages.add({
        "role": data.isUser == true ? 'user' : 'assistant',
        "content": content
      });
    }
    if (messages.isEmpty) {
      messages.add({"role": 'user', "content": userMessage});
    }
    request.body = jsonEncode({
      "model": ApiProvider.aiModel,
      "messages": messages,
      "temperature": 0.5,
      "stream": true
    });
    final response = await http.Client().send(request);
    final stream = response.stream
        .transform(utf8.decoder)
        .timeout(const Duration(seconds: 60));
    Logger().d('Response status: ${response.statusCode}');
    return stream;
  }

  ///
  /// Python API
  ///
  Future<Stream<String>> sendMessageStreamApi(String message) async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/chat');
    var request = http.Request('POST', uri);
    request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    request.body = jsonEncode({"question": message});
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 120));
    final stream =
        response.stream.transform(utf8.decoder).transform(const LineSplitter());
    return stream;
  }
}

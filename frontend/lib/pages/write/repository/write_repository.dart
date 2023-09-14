import 'dart:convert';
import 'package:frontend/utils/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WriteRepository {
  static final WriteRepository _singleton = WriteRepository._();

  static WriteRepository get instance => _singleton;

  WriteRepository._();

  ///
  /// Directly request openai api
  ///
  Future<Stream<String>> sendMessageStream(String system, String prompt) async {
    Logger().d('role = $system,prompt = $prompt');
    var url = Uri.https('api.openai.com', 'v1/chat/completions');
    var request = http.Request('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${ApiProvider.aiApiKey}',
      'Content-Type': 'application/json; charset=UTF-8'
    });
    request.body = jsonEncode({
      "model": ApiProvider.aiModel,
      "messages": [
        {"role": "system", "content": system},
        {"role": "user", "content": prompt}
      ],
      "temperature": 0.5,
      "stream": true
    });
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 60));
    final stream = response.stream.transform(utf8.decoder);
    Logger().d('Response status: ${response.statusCode}');
    return stream;
  }

  ///
  /// Python API
  ///
  Future<Stream<String>> sendMessageStreamApi(
      String system, String message) async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/write');
    var request = http.Request('POST', uri);
    request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    request.body = jsonEncode({'system': system, 'question': message});
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 120));
    final stream =
        response.stream.transform(utf8.decoder).transform(const LineSplitter());
    return stream;
  }
}

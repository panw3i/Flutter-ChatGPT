import 'dart:convert';

import 'package:frontend/utils/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TranslateRepository {
  static final TranslateRepository _singleton = TranslateRepository._();

  static TranslateRepository get instance => _singleton;

  TranslateRepository._();

  Future<http.Response> translateInput(
      String inputStr, String inputType, String targetType) async {
    var url = Uri.https('api.openai.com', 'v1/chat/completions');
    final headers = {
      'Authorization': 'Bearer ${ApiProvider.aiApiKey}',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final body = jsonEncode({
      "model": ApiProvider.aiModel,
      "messages": [
        {
          "role": "user",
          "content":
              'Translate the following $inputType text to $targetType: $inputStr'
        }
      ]
    });
    Logger().d('request params = $body');
    return await http
        .post(url, body: body, headers: headers)
        .timeout(const Duration(seconds: 45));
  }

  Future<Stream<String>> sendMessageStreamApi(String message) async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/translate');
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

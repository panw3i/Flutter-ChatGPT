import 'dart:async';
import 'dart:convert';

import 'package:frontend/pages/document/model/doc_default_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DocRepository {
  static final DocRepository _singleton = DocRepository._();

  static DocRepository get instance => _singleton;

  DocRepository._();

  ///
  /// 查询向量问答，根据queryType区分向量化模型
  /// 1 -> 文本相似度检索,
  /// 2 -> 树形文档摘要,
  /// 3-> 总结文档
  ///
  Future<Stream<String>> sendMessageStream(
      String message, int queryType, String fileName) async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/document/query');
    var request = http.Request('POST', uri);
    request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8'});
    request.body = jsonEncode(
        {"question": message, "query_type": queryType, "file_name": fileName});
    final response =
        await http.Client().send(request).timeout(const Duration(seconds: 120));
    final stream =
        response.stream.transform(utf8.decoder).transform(const LineSplitter());
    return stream;
  }

  ///
  /// 上传文件，根据queryType区分向量化模型
  /// 1 -> 文本相似度检索,
  /// 2 -> 树形文档摘要,
  /// 3-> 总结文档
  ///
  Future uploadFile(int queryType, String uniqueKey, PlatformFile file,
      Function(Map<String, dynamic> parans) onUpload) async {
    final bytes = file.bytes;
    try {
      var uri = Uri.parse(
          'http://127.0.0.1:8000/api/llm/v1/file/upload?query_type=$queryType');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes('file', bytes as List<int>,
            filename: file.name));
      final response =
          await request.send().timeout(const Duration(seconds: 120));
      Logger().d('response = ${response.statusCode}');
      await for (var data in response.stream.transform(utf8.decoder)) {
        Logger().d('data = $data');
        final result = jsonDecode(data);
        onUpload(result);
      }
    } catch (e) {
      Logger().d('File upload error = $e');
      onUpload({'msg': 'File upload error = $e', 'code': -1});
    }
  }

  ///
  /// 获取向量化文件列表
  /// [Vector Doc List]
  ///
  Future<DocDefaultFile> getVectorFileList() async {
    var uri = Uri.parse('http://127.0.0.1:8000/api/llm/v1/file/vector/list');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8'
    }).timeout(const Duration(seconds: 45));
    final defaultFile =
        DocDefaultFile.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return defaultFile;
  }
}

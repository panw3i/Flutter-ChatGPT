///
/// 解析python服务器端文件列表模型
/// python api model
///
class DocDefaultFile {
  DocDefaultFile({this.code, this.msg, this.result});

  DocDefaultFile.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    result = json['result'] != null ? json['result'].cast<String>() : [];
  }

  num? code;
  String? msg;
  List<String>? result;

  DocDefaultFile copyWith({num? code, String? msg, List<String>? result}) =>
      DocDefaultFile(
          code: code ?? this.code,
          msg: msg ?? this.msg,
          result: result ?? this.result);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['result'] = result;
    return map;
  }
}

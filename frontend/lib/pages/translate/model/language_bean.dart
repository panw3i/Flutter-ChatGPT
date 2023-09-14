/// code : "zh"
/// name : "Chinese"
/// native : "中文"

class LanguageBean {
  LanguageBean({this.code, this.name, this.native, this.checked, this.hint});

  LanguageBean.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    native = json['native'];
    checked = json['checked'];
    hint = json['hint'];
  }

  String? code;
  String? name;
  String? native;
  bool? checked;
  String? hint;

  LanguageBean copyWith(
          {String? code, String? name, String? native, bool? checked}) =>
      LanguageBean(
        code: code ?? this.code,
        name: name ?? this.name,
        native: native ?? this.native,
        checked: checked ?? this.checked,
        hint: hint ?? this.hint,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['name'] = name;
    map['native'] = native;
    map['checked'] = checked;
    map['hint'] = hint;
    return map;
  }
}

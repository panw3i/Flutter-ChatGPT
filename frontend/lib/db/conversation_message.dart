///
/// 全局聊天对话-消息模型
/// Global Conversation-Message Model
///
class Conversations {
  Conversations({this.id, this.title});

  Conversations.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  num? id;
  String? title;

  Conversations copyWith({num? id, String? title}) =>
      Conversations(id: id ?? this.id, title: title ?? this.title);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class Messages {
  Messages({this.id, this.message, this.time, this.isUser});

  Messages.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    time = json['time'];
    isUser = json['isUser'];
  }

  num? id;
  String? message;
  String? time;
  bool? isUser;

  Messages copyWith({num? id, String? message, String? time, bool? isUser}) =>
      Messages(
          id: id ?? this.id,
          message: message ?? this.message,
          time: time ?? this.time,
          isUser: isUser ?? this.isUser);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['time'] = time;
    map['isUser'] = isUser;
    return map;
  }
}

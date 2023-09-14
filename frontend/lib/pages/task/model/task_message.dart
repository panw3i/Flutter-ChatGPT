///
/// AI-Task Model
///
class TaskMessages {
  TaskMessages({this.message, this.time, this.isUser});

  TaskMessages.fromJson(dynamic json) {
    message = json['message'];
    time = json['time'];
    isUser = json['isUser'];
  }

  String? message;
  String? time;
  bool? isUser;

  TaskMessages copyWith(
          {num? id, String? message, String? time, bool? isUser}) =>
      TaskMessages(
          message: message ?? this.message,
          time: time ?? this.time,
          isUser: isUser ?? this.isUser);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['time'] = time;
    map['isUser'] = isUser;
    return map;
  }
}

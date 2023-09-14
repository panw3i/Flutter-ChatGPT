/// id : "chatcmpl-7XkG7basi7G666pEK6blC7LKcBdso"
/// object : "chat.completion"
/// created : 1688276999
/// model : "gpt-3.5-turbo-0613"
/// choices : [{"index":0,"message":{"role":"assistant","content":"How should I learn to study Android project code?"},"finish_reason":"stop"}]
/// usage : {"prompt_tokens":28,"completion_tokens":10,"total_tokens":38}

class TranslateModel {
  TranslateModel({
      this.id, 
      this.object, 
      this.created, 
      this.model, 
      this.choices, 
      this.usage,});

  TranslateModel.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }
  String? id;
  String? object;
  num? created;
  String? model;
  List<Choices>? choices;
  Usage? usage;
TranslateModel copyWith({  String? id,
  String? object,
  num? created,
  String? model,
  List<Choices>? choices,
  Usage? usage,
}) => TranslateModel(  id: id ?? this.id,
  object: object ?? this.object,
  created: created ?? this.created,
  model: model ?? this.model,
  choices: choices ?? this.choices,
  usage: usage ?? this.usage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['created'] = created;
    map['model'] = model;
    if (choices != null) {
      map['choices'] = choices?.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      map['usage'] = usage?.toJson();
    }
    return map;
  }

}

/// prompt_tokens : 28
/// completion_tokens : 10
/// total_tokens : 38

class Usage {
  Usage({
      this.promptTokens, 
      this.completionTokens, 
      this.totalTokens,});

  Usage.fromJson(dynamic json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }
  num? promptTokens;
  num? completionTokens;
  num? totalTokens;
Usage copyWith({  num? promptTokens,
  num? completionTokens,
  num? totalTokens,
}) => Usage(  promptTokens: promptTokens ?? this.promptTokens,
  completionTokens: completionTokens ?? this.completionTokens,
  totalTokens: totalTokens ?? this.totalTokens,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prompt_tokens'] = promptTokens;
    map['completion_tokens'] = completionTokens;
    map['total_tokens'] = totalTokens;
    return map;
  }

}

/// index : 0
/// message : {"role":"assistant","content":"How should I learn to study Android project code?"}
/// finish_reason : "stop"

class Choices {
  Choices({
      this.index, 
      this.message, 
      this.finishReason,});

  Choices.fromJson(dynamic json) {
    index = json['index'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    finishReason = json['finish_reason'];
  }
  num? index;
  Message? message;
  String? finishReason;
Choices copyWith({  num? index,
  Message? message,
  String? finishReason,
}) => Choices(  index: index ?? this.index,
  message: message ?? this.message,
  finishReason: finishReason ?? this.finishReason,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = index;
    if (message != null) {
      map['message'] = message?.toJson();
    }
    map['finish_reason'] = finishReason;
    return map;
  }

}

/// role : "assistant"
/// content : "How should I learn to study Android project code?"

class Message {
  Message({
      this.role, 
      this.content,});

  Message.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
  }
  String? role;
  String? content;
Message copyWith({  String? role,
  String? content,
}) => Message(  role: role ?? this.role,
  content: content ?? this.content,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    return map;
  }

}
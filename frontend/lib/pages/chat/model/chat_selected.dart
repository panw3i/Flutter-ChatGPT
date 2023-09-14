///
/// 对话列表选中模型
/// Conversation selected model
///
class ChatSelected {
  int index;

  /// 对话id
  num? conversationId;

  //是否默认选中
  bool isDefault;

  ChatSelected({this.index = 0, this.conversationId, this.isDefault = false});
}

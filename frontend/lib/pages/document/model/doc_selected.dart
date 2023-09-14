///
/// 文档对话选中模型
/// [doc conversation selected model]
///
class DocSelected {
  //对话下标
  int index;

  //对话id
  num? conversationId;

  //对话title - 文档标题
  String? conversationTitle;

  //uuid
  String? uniqueKey;

  //是否默认选中
  bool isDefault;

  DocSelected(
      {this.index = 0,
      this.conversationId,
      this.conversationTitle = '',
      this.uniqueKey = '',
      this.isDefault = false});
}

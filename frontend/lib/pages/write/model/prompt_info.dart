/// title : "生成内容配置项"
/// content : ""
/// label : ""
/// topic : "主题名称"
/// tip : "主题内容"

class PromptInfo {
  String title;
  String content;
  String label;
  String topic;
  String prompt;
  String system;

  PromptInfo({
    this.title = '',
    this.content = '',
    this.label = '',
    this.topic = '',
    this.prompt = '',
    this.system = '',
  });
}

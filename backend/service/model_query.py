from pydantic import BaseModel


# 文档提问
class Question(BaseModel):
    # 1 表示default ,  2 表示tree_summarize ， 3 表示summarize
    query_type: int
    question: str = ""
    file_name: str = ""


# 对话聊天
class ChatModel(BaseModel):
    # 用户输入
    question: str = ""
    # 系统角色模版
    system: str = ""

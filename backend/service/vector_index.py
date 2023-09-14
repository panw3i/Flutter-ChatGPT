import os

from langchain.chat_models import ChatOpenAI
from langchain.text_splitter import SpacyTextSplitter
from llama_index import SimpleDirectoryReader, LLMPredictor, PromptHelper, ServiceContext, \
    GPTVectorStoreIndex, StorageContext, GPTListIndex, GPTTreeIndex
from llama_index.node_parser import SimpleNodeParser


# [PromptHelper]format input params
def create_service_context():
    max_input_size = 4096
    num_outputs = 512
    max_chunk_overlap = 0.3
    chunk_size_limit = 600

    prompt_helper = PromptHelper(max_input_size, num_outputs, max_chunk_overlap, chunk_size_limit=chunk_size_limit)
    llm_predictor = LLMPredictor(
        llm=ChatOpenAI(temperature=0, model_name="gpt-3.5-turbo-0613",
                       max_tokens=num_outputs, streaming=True))
    service_context = ServiceContext.from_defaults(llm_predictor=llm_predictor, prompt_helper=prompt_helper)
    return service_context


# [PromptHelper]format input params
def create_summary_service_context():
    prompt_helper = PromptHelper(max_input_size=4096, num_output=1024, chunk_overlap_ratio=0.3,
                                 chunk_size_limit=600)
    llm_predictor = LLMPredictor(
        llm=ChatOpenAI(temperature=0, model_name="gpt-3.5-turbo-0613",
                       max_tokens=1024, streaming=True))
    service_context = ServiceContext.from_defaults(llm_predictor=llm_predictor, prompt_helper=prompt_helper)
    return service_context


# 初始化本地文件数据索引
# [GPTVectorStoreIndex]
def init_local_index():
    if os.path.exists(os.path.join("storage", "vector_store.json")):
        print("Vector file has existed")
        return
    # 加载data下所有文档
    documents = SimpleDirectoryReader("./data", filename_as_id=True).load_data()
    # 构建索引
    # storage_context = StorageContext.from_defaults(persist_dir="./storage")
    index = GPTVectorStoreIndex.from_documents(documents,
                                               service_context=create_service_context())
    default_file_name = os.listdir("data")[0]
    # 设置索引id
    index.set_index_id(default_file_name)
    # 持久化索引
    index.storage_context.persist()


# 上传文件,索引插入文档
# [GPTVectorStoreIndex]
async def create_file_index(file_name: str, file_path: str):
    documents = SimpleDirectoryReader(input_files=[file_path], filename_as_id=True).load_data()
    print(f"Load doc = {documents}")
    # 查询索引
    storage_context = StorageContext.from_defaults(persist_dir="./storage")
    # 构建索引
    index = GPTVectorStoreIndex.from_documents(documents, storage_context=storage_context,
                                               service_context=create_service_context())
    # 设置索引id
    index.set_index_id(file_name)
    # 持久化索引
    index.storage_context.persist()


# 上传文件,解析node,
# 适用GPTListIndex - 树形文档摘要
# [Tree Summaries][ListIndex]
async def create_file_tree_summarize_index(file_name: str, file_path: str):
    storage_context = StorageContext.from_defaults(persist_dir="./storage")
    # 构建分词器
    text_splitter = SpacyTextSplitter(pipeline="zh_core_web_sm", chunk_size=2048)
    # 构建NodeParser
    parser = SimpleNodeParser(text_splitter=text_splitter)
    # 加载文档
    documents = SimpleDirectoryReader(input_files=[file_path], filename_as_id=True).load_data()
    # 分割文本
    nodes = parser.get_nodes_from_documents(documents)
    # 构建ListIndex
    index = GPTListIndex(nodes=nodes, storage_context=storage_context,
                         service_context=create_summary_service_context())
    # 设置索引id
    index.set_index_id(file_name)
    # 持久化索引
    index.storage_context.persist()


# 上传文件,解析node,
# 适用GPTTreeIndex - 总结文档
# [Tree Summaries][TreeIndex]
async def create_file_summarize_index(file_name: str, file_path: str):
    storage_context = StorageContext.from_defaults(persist_dir="./storage")
    # 构建分词器
    text_splitter = SpacyTextSplitter(pipeline="zh_core_web_sm", chunk_size=2048)
    # 构建NodeParser
    parser = SimpleNodeParser(text_splitter=text_splitter)
    # 加载文档
    documents = SimpleDirectoryReader(input_files=[file_path], filename_as_id=True).load_data()
    # 分割文本
    nodes = parser.get_nodes_from_documents(documents)
    # 构建ListIndex
    index = GPTTreeIndex(nodes=nodes, storage_context=storage_context,
                         service_context=create_summary_service_context())
    # 设置索引id
    index.set_index_id(file_name)
    # 持久化索引
    index.storage_context.persist()

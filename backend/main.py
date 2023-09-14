import asyncio
import datetime
import json
import logging
import os
import sys
from collections import OrderedDict
import openai
import uvicorn
from dotenv import load_dotenv
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from langchain import ConversationChain
from langchain.chat_models import ChatOpenAI
from langchain.memory import ConversationBufferWindowMemory
from langchain.schema import HumanMessage, SystemMessage
from llama_index import StorageContext, load_index_from_storage
from sse_starlette.sse import EventSourceResponse

from service.function_call import functionInfo, functionCall, query_attendance_data, query_inventory_data, \
    submit_leave_data
from service.model_query import Question, ChatModel
from service.vector_index import create_service_context, create_file_index, init_local_index, \
    create_file_tree_summarize_index, create_file_summarize_index

# load .env prams
load_dotenv()

# openai
openai.log = "debug"
openai.api_key = os.environ["OPENAI_API_KEY"]

# logging
logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

# init index
init_local_index()
# chat_model
chat_model = ChatOpenAI(temperature=0.5, model_name="gpt-3.5-turbo-0613",
                        max_tokens=1024, streaming=True)
# ConversationBufferWindowMemory
conversation_chain = ConversationChain(
    llm=chat_model,
    # prompt=default_prompt,
    memory=ConversationBufferWindowMemory(k=2),
    verbose=True
)


@app.post("/api/llm/v1/file/upload", summary="Upload doc to vectorize it")
async def upload_file(query_type: int, file: UploadFile = File(...)):
    file_path = "data/" + file.filename
    if os.path.isfile(file_path):
        return {"code": -1, "msg": "[" + file.filename + "]upload failure,file has exist", 'result': 0}
    f = open(file_path, 'wb')
    data = await file.read()
    f.write(data)
    f.close()
    logging.info("File write finished，starting process doc vector")
    if query_type == 1:
        # 文本相似度检索 [Retrieval]
        await create_file_index(file.filename, file_path)
    elif query_type == 2:
        # 树形文档摘要 [Tree Summaries]
        await create_file_tree_summarize_index(file.filename, file_path)
    else:
        # 总结文档 [Summaries]
        await create_file_summarize_index(file.filename, file_path)
    return {"code": 0, "msg": "[" + file.filename + "]upload success", 'result': f"Text Length = {len(data)}"}


@app.get("/api/llm/v1/file/vector/list", summary="Query vectorized file list")
async def query_vector_file_list():
    def dict_to_ordereddict(d):
        return OrderedDict(d)

    with open('storage/index_store.json', 'r') as file:
        data = json.load(file, object_pairs_hook=dict_to_ordereddict)
        # data = json.load(file)
        keys = list(data['index_store/data'].keys())
        return {"code": 0, "msg": 'Success', "result": keys}


@app.post("/api/llm/v1/document/query", summary="Local knowledge base & vectorized document retrieval")
async def query(data: Question) -> EventSourceResponse:
    print(f"Start Request - time = {datetime.datetime.now()}")
    storage_context = StorageContext.from_defaults(persist_dir="./storage")
    print(f"File Name - time = {datetime.datetime.now()},{data.file_name}")
    index = load_index_from_storage(storage_context, index_id=data.file_name,
                                    service_context=create_service_context())
    print(f"Vector Query - time = {datetime.datetime.now()},{index}")
    # 文本相似度检索 [Retrieval]
    if data.query_type == 1:
        query_engine = index.as_query_engine(streaming=True, similarity_top_k=1).query(data.question)
    # 树形文档摘要 [Tree Summaries]
    elif data.query_type == 2:
        query_engine = index.as_query_engine(streaming=True, response_mode="tree_summarize").query(
            data.question)
    # 总结文档 [Summaries]
    else:
        query_engine = index.as_query_engine(streaming=True, mode="summarize").query(data.question)

    # 解析流文本 [Parse Stream Text] [Parse Stream Text]
    async def stream_generator():
        for text in query_engine.response_gen:
            print(f"End Request-Parse Text[time:{datetime.datetime.now()}][text:{text}]")
            if len(text) == 0:
                continue
            yield text
            await asyncio.sleep(0.016)

    print(f"Return Data - time = {datetime.datetime.now()}")
    return EventSourceResponse(stream_generator())


@app.post("/api/llm/v1/chat", summary="Conversation Memory")
async def chat(data: ChatModel) -> EventSourceResponse:
    print(f"Start Request - time = {datetime.datetime.now()}")
    # conversation_chain = create_conversation_memory()
    chat_response = conversation_chain.predict(input=data.question)
    print(f"Response Content - \n{chat_response}")

    # 解析流文本 [Parse Stream Text]
    async def stream_generator():
        for text in chat_response:
            print(f"End Request-Parse Text[time:{datetime.datetime.now()}][text:{text}]")
            if len(text) == 0:
                continue
            yield text
            await asyncio.sleep(0.016)

    print(f"Return Data - time = {datetime.datetime.now()}")
    return EventSourceResponse(stream_generator())


@app.post("/api/llm/v1/translate", summary="Translate multiple languages")
async def translate(data: ChatModel) -> EventSourceResponse:
    print(f"Start Request - time = {datetime.datetime.now()}")
    # chat_model = create_chat_model()
    translate_response = chat_model.predict(text=data.question)
    print(f"Response Content - \n{translate_response}")

    # 解析流文本 [Parse Stream Text]
    async def stream_generator():
        for text in translate_response:
            print(f"End Request-Parse Text[time:{datetime.datetime.now()}][text:{text}]")
            if len(text) == 0:
                continue
            yield text
            await asyncio.sleep(0.016)

    print(f"Return Data - time = {datetime.datetime.now()}")
    return EventSourceResponse(stream_generator())


@app.post("/api/llm/v1/write", summary="AI-Write")
async def write(data: ChatModel) -> EventSourceResponse:
    print(f"Start Request - time = {datetime.datetime.now()}")
    # chat_model = create_chat_model()
    write_message = chat_model.predict_messages(
        messages=[SystemMessage(content=data.system), HumanMessage(content=data.question)])
    print(f"Response Content - \n{write_message.content}")

    # 解析流文本 [Parse Stream Text]
    async def stream_generator():
        for text in write_message.content:
            print(f"End Request-Parse Text[time:{datetime.datetime.now()}][text:{text}]")
            if len(text) == 0:
                continue
            yield text
            await asyncio.sleep(0.016)

    print(f"Return Data - time = {datetime.datetime.now()}")
    return EventSourceResponse(stream_generator())


@app.post("/api/llm/v1/task", summary="AI-Task")
async def task(data: ChatModel):
    print(f"Start Request - time = {datetime.datetime.now()}")
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-0613",
        messages=[{"role": "user", "content": data.question}],
        functions=functionInfo,
        function_call="auto")
    print(f"Response Content - \n{response}")
    message = response['choices'][0]['message']
    function_call = message['function_call']
    # if param[function_call] is null, it means do not process next task
    if function_call is None:
        return "\nerror: {message['content']}"
    function_name = message['function_call']['name']
    function_args = json.loads(function_call['arguments'])
    print("check function")
    if function_name not in functionCall:
        return "\nerror: Sorry，AI-Assistant does not know the answer to this question yet"
    # match function : query_attendance_data
    if function_name == functionCall[0]:
        attendance_data = await query_attendance_data(
            function_args['attendance_date'], function_args['attendance_depart'])
        # json.loads
        data_json = json.loads(attendance_data.text)
        if data_json['code'] != 0:
            return "\nerror: Sorry，AI-Assistant does not know the answer to this question yet"
        # json.dumps
        content_data = json.dumps(data_json['result'])
    # match function : query_inventory_data
    elif function_name == functionCall[1]:
        inventory_data = await query_inventory_data(
            function_args['brand'], function_args['sku_code'])
        json_data = json.loads(inventory_data.text)
        if json_data['code'] != 0:
            return "\nerror: Sorry，AI-Assistant does not know the answer to this question yet"
        content_data = json.dumps(json_data['result'])
    # match function : submit_leave_data
    else:
        leave_data = await submit_leave_data(
            function_args['date_start'],
            function_args['time_start'],
            function_args['date_end'],
            function_args['time_end'],
            function_args['leave_reason'])
        json_data = json.loads(leave_data.text)
        if json_data['code'] != 0:
            return "\nerror: Sorry，AI-Assistant does not know the answer to this question yet"
        content_data = json.dumps(json_data)
    # merge functions info and contentData
    data_response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo-0613",
        messages=[
            {"role": "user", "content": data.question},
            message,
            {"role": "function", "name": function_name, "content": content_data}
        ],
        stream=True,
        functions=functionInfo,
        function_call="auto")

    # 解析流文本 [Parse Stream Text]
    async def stream_generator():
        for chunk in data_response:
            if "content" in chunk['choices'][0]['delta']:
                content = chunk['choices'][0]['delta']['content']
                if len(content) == 0:
                    continue
                yield content
                await asyncio.sleep(0.016)

    print(f"Return Data - time = {datetime.datetime.now()}")
    return EventSourceResponse(stream_generator())


@app.post("/api/llm/v1/inventory/query", summary="Query Zeiss lens inventory data")
async def query_inventory():
    response = await query_inventory_data(brand="Zeiss", sku_code="6974332860066")
    print(response.content)
    print(response.text)
    return response.text


@app.post("/api/llm/v1/attendance/query", summary="Query attendance data")
async def query_inventory():
    response = await query_attendance_data(date="2023-07-28", depart="研发部")
    print(response.content)
    print(response.text)
    return response.text


@app.post("/api/llm/v1/leave/submit", summary="Submit leave data")
async def query_inventory():
    response = await submit_leave_data(
        date_start="2023-07-28", time_start="09:00", date_end="2023-07-28",
        time_end="18:00",
        leave_reason="下周一温度太高，无法前往公司上班")
    print(response.content)
    print(response.text)
    return response.text


if __name__ == "__main__":
    # name_app = os.path.basename(__file__)[0:-3]  # Get the name of the script
    # log_config = {
    #     "version": 1,
    #     "disable_existing_loggers": True,
    #     "handlers": {
    #         "file_handler": {
    #             "class": "logging.FileHandler",
    #             "filename": "logfile.log",
    #         },
    #     },
    #     "root": {
    #         "handlers": ["file_handler"],
    #         "level": "INFO",
    #     },
    # }
    uvicorn.run(app='main:app', host="127.0.0.1", port=8000, reload=True)
# iface = gr.Interface(fn=data_querying,
#                      inputs=gr.components.Textbox(lines=7, label="Enter your question"),
#                      outputs="text",
#                      title="Flutter-ChatGPT")
#
# iface.launch(share=False)

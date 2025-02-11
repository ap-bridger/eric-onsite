from langchain_anthropic import ChatAnthropic
from langchain_core.messages import HumanMessage
from langgraph.prebuilt import create_react_agent
from fastapi import FastAPI
from pydantic import BaseModel

import categorize_service

model = ChatAnthropic(model="claude-3-haiku-20240307")
tools = []
graph = create_react_agent(model, tools)

app = FastAPI()

class Request(BaseModel):
    username: str

@app.post("/agent")
async def agent(request: Request):
    prompt = f"Hello my name is {request.username}. Greet me by my name please, and try to mix things up"
    result = graph.invoke({"messages": [HumanMessage(prompt)]})
    response = result["messages"][-1]
    return response.content


@app.post("/categorize")
async def categorize(transaction: categorize_service.Transaction):

    top_payee_list, top_category_list = categorize_service.categorize(transaction)

    return {
        "top_payee_list": top_payee_list,
        "top_category_list": top_category_list,
    }


def main():
    categorize_service.load_training_data()



main()

# if __name__ == "__main__":
#     print("Hello, World!")
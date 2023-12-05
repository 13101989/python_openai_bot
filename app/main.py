import uvicorn
from fastapi import FastAPI, HTTPException, Query

from app.HttpxClient import HttpxClient


app = FastAPI()
httpx_client = HttpxClient()

stored_question = ""


@app.get("/")
async def get_root(
    question: str = Query("How are you?", description="Question to ask the chatbot")
):
    global stored_question
    stored_question = question
    return {
        "message": "You can interact with ChatGPT by using this format url: /?question=YOUR%20QUESTION%20HERE and retrieve the answer at /message"
    }


@app.get("/message")
async def get_answer():
    if not stored_question:
        raise HTTPException(
            status_code=400,
            detail="No question stored. Please send a question to the root endpoint first.",
        )
    response = await httpx_client.post(stored_question)
    return response


@app.get("/healthcheck")
async def get_healthcheck_data():
    return {"message": "At this endpoint I will return healthcheck data"}


@app.get("/version")
async def get_version():
    return {"message": "At this endpoint I will return the version of the chatbot"}


if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)


# python3 -m venv venv
# . venv/bin/activate
# pip install --upgrade pip setuptools wheel
# pip install -r requirements.txt
# python app/main.py

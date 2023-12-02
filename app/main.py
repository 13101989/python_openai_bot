"""Module docstring"""
import uvicorn
from fastapi import FastAPI


app = FastAPI()


@app.get("/")
async def get_root():
    """function docstring"""
    return {"message": "Welcome to the conversational chatbot"}


@app.get("/message")
async def get_answer():
    """function docstring"""
    return {"message": "At this endpoint I will return the answers to the questions"}


@app.get("/healthcheck")
async def get_healthcheck_data():
    """function docstring"""
    return {"message": "At this endpoint I will return healthcheck data"}


@app.get("/version")
async def get_version():
    """function docstring"""
    return {"message": "At this endpoint I will return the version of the chatbot"}


if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)


# python3 -m venv venv
# . venv/bin/activate
# pip install --upgrade pip setuptools wheel
# pip install -r requirements.txt
# python app/main.py

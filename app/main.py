from pathlib import Path
import uvicorn
import yaml
from fastapi import FastAPI, Query

from app.httpclient.HttpxClient import HttpxClient

app = FastAPI()
httpx_client = HttpxClient()

PATH = Path(".") / "version.yml"


@app.get("/")
async def get_root():
    return {"message": "You are at the root endpoint."}


@app.get("/message")
async def get_answer(question: str = Query("What is your name?")):
    response = await httpx_client.post(question)
    return response


@app.get("/healthcheck")
async def get_healthcheck_data():
    return {"message": "Chatbot is healthy"}


@app.get("/version")
async def get_version():
    with open(PATH, "r") as file:
        yaml_content = yaml.safe_load(file)
    return f"version: {yaml_content['version']}"


if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)


# python3 -m venv venv
# . venv/bin/activate
# pip install --upgrade pip setuptools wheel
# pip install -r requirements.txt
# python app/main.py

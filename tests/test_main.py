from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_get_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "You are at the root endpoint."}


def test_get_answer():
    response = client.get("/message")
    assert response.status_code == 200


def test_healthcheck_data():
    response = client.get("/healthcheck")
    assert response.status_code == 200
    assert response.json() == {"message": "Chatbot is healthy"}


def test_get_version():
    response = client.get("/version")
    assert response.status_code == 200
    assert response.json() == "version: 1.1.1"

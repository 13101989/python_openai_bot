"""Module docstring"""
from fastapi.testclient import TestClient
from app.main import app


client = TestClient(app)


def test_get_root():
    """function docstring"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the conversational chatbot"}


def test_get_answer():
    """function docstring"""
    response = client.get("/message")
    assert response.status_code == 200
    # pylint: disable=C0301
    assert response.json() == {
        "message": "At this endpoint I will return the answers to the questions"
    }


def test_healthcheck_data():
    """function docstring"""
    response = client.get("/healthcheck")
    assert response.status_code == 200
    assert response.json() == {
        "message": "At this endpoint I will return healthcheck data"
    }


def test_get_version():
    """function docstring"""
    response = client.get("/version")
    assert response.status_code == 200
    # pylint: disable=C0301
    assert response.json() == {
        "message": "At this endpoint I will return the version of the chatbot"
    }

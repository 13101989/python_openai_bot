from fastapi.testclient import TestClient
from app.main import app


client = TestClient(app)


# def test_get_root(question: str = Query(None, description="Question to ask the chatbot")):
#     response = client.get("/")
#     assert response.status_code == 200
#     assert response.json() == {
#         "message": "You can interact with ChatGPT by using this format url: /?question=YOUR%20QUESTION%20HERE and retrieve the answer at /message"
#         }


# def test_get_answer():
#     response = client.get("/message")
#     assert response.status_code == 200
#     # pylint: disable=C0301
#     assert response.json() == {
#         "message": "As an AI, I don't have emotions, but I'm here to help you with any questions or tasks you might have. How can I assist you today?"
#     }


def test_healthcheck_data():
    response = client.get("/healthcheck")
    assert response.status_code == 200
    assert response.json() == {
        "message": "At this endpoint I will return healthcheck data"
    }


def test_get_version():
    response = client.get("/version")
    assert response.status_code == 200
    assert response.json() == {
        "message": "At this endpoint I will return the version of the chatbot"
    }

FROM python:latest

# Copy files to container
COPY . /chatbot
WORKDIR /chatbot

# Install python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Build Sphinx documentation
WORKDIR /chatbot/docs
RUN make html
WORKDIR /chatbot/docs/build/html

EXPOSE 8001

ENTRYPOINT ["python3", "-m", "http.server", "8001"]

# docker build -t bot_image --no-cache .
# docker run -it -p 127.0.0.1:8001:8001 --name bot_docs_container bot_image
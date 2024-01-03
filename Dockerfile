FROM python:latest

# Copy files to container
COPY . /chatbot
WORKDIR /chatbot

# Install python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Build Sphinx documentation
RUN make html

# Set environment variables
ARG OPENAI_KEY
ENV OPENAI_KEY=$OPENAI_KEY

EXPOSE 8000

ENTRYPOINT ["python3", "app/main.py"]

# docker build --build-arg OPENAI_KEY -t bot_image --no-cache .
# docker run -it -p 127.0.0.1:8000:8000 --name bot_container bot_image
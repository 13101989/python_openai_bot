FROM ubuntu:latest

# Install dependencies:
RUN apt update -y && apt upgrade -y

# Install Python 3.12:
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install python3.12-full -y
ENV DEBIAN_FRONTEND=

# Install python dependencies:
RUN apt-get update && apt-get install -y python3-pip \
                                         python3-dev \
                                         build-essential

# Create symbolic links for python 3.12:
# RUN rm /usr/bin/python3
# RUN ln -s /usr/bin/python3.12 /usr/bin/python3
# RUN ln -s /usr/bin/python3.12 /usr/bin/python

# Create symbolic links for default python:
RUN ln -s /usr/bin/python3 /usr/bin/python

ENTRYPOINT [ "bin/bash" ]

# docker build -t bot_image --no-cache .
# docker run -it --name bot_container bot_image
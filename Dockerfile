FROM ubuntu:latest
RUN apt update -y
RUN apt install -y build-essential curl
RUN curl -sSL https://get.haskellstack.org/ | sh
WORKDIR /home
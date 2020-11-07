FROM ubuntu:latest
RUN apt update 
RUN apt install -y build-essential curl
RUN curl -sSL https://get.haskellstack.org/ | sh
CMD [ "sh", "/home/build.sh" ]
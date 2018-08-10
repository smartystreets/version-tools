FROM alpine:latest

RUN apk add make git

RUN wget -qO - "https://github.com/github/hub/releases/download/v2.5.0/hub-linux-amd64-2.5.0.tgz" | tar -xvz -C / --strip 1

COPY . /code
WORKDIR /code

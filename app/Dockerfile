FROM golang:1.16-buster

ADD ./ /app

WORKDIR /app

RUN go get

CMD go run main.go

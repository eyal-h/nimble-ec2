FROM golang:1.16-buster

ADD ./ /app

WORKDIR /app

RUN go mod init example.com/m

RUN go get

CMD go run main.go

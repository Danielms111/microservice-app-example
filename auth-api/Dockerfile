FROM golang:1.19

WORKDIR /go/src/app

COPY . .

RUN go mod tidy

RUN go build -o auth-api

CMD ["./auth-api"]

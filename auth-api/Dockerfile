FROM golang:1.18

WORKDIR /app
COPY . .

ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://users-api:8083

# Instalar dep y restaurar dependencias
RUN go install github.com/golang/dep/cmd/dep@latest

ENV GO111MODULE=off

RUN dep ensure


RUN go build -o auth-api

CMD ["./auth-api"]

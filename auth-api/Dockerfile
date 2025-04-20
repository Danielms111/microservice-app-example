FROM golang:1.18

WORKDIR /app
COPY . .

ENV GO111MODULE=on
ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://users-api:8083

RUN go mod tidy
RUN go build -o auth-api

CMD ["./auth-api"]

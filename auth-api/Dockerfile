FROM golang:1.19

WORKDIR /app
COPY . .

ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://users-api:8083

# Instalar 'dep' y restaurar las dependencias
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN dep ensure

# Construir el proyecto
RUN go build -o auth-api

CMD ["./auth-api"]

FROM golang:1.19


ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

WORKDIR $GOPATH/src/app

COPY . .

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN dep ensure

RUN go build -o auth-api

EXPOSE 8000

CMD ["./auth-api"]

FROM golang:1.10-alpine3.8

VOLUME ["/build", "/gopath"]

ENV GOPATH="/gopath"
ENV GOBIN="${GOPATH}/bin"
ENV GOOS=linux
ENV GOARCH=amd64

RUN apk add --no-cache librdkafka librdkafka-dev alpine-sdk libressl-dev musl-dev zlib-dev

WORKDIR /gopath

CMD ["go", "version"]
FROM alpine:3.6

VOLUME ["/build", "/gopath"]

ENV GOPATH="/gopath"
ENV GOBIN="${GOPATH}/bin"
ENV GOOS=linux
ENV GOARCH=amd64

RUN apk add --no-cache go; sed -i -e 's/v3\.6/edge/g' /etc/apk/repositories
RUN apk add --no-cache librdkafka librdkafka-dev alpine-sdk libressl-dev musl-dev zlib-dev

WORKDIR /gopath/

CMD ["go","version"]
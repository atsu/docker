# Dockerfile is auto-generated via m4 macro processing

FROM golang:1.15.2-alpine3.12
RUN apk add --no-cache \
    alpine-sdk==1.0-r0 \
    git==2.26.2-r0 \
    librdkafka-dev==1.4.2-r0 \
    librdkafka==1.4.2-r0 \
    libressl-dev==3.1.2-r0 \
    musl-dev==1.1.24-r9 \
    openssh==8.3_p1-r0 \
    zlib-dev==1.2.11-r3

include(`sqrl.m4')

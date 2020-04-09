# Dockerfile is auto-generated via m4 macro processing

FROM golang:1.12.7-alpine3.10
RUN apk add --no-cache \
    alpine-sdk=1.0-r0 \
    git=2.22.0-r0 \
    librdkafka-dev=1.0.1-r1 \
    librdkafka=1.0.1-r1 \
    libressl-dev=2.7.5-r0 \
    musl-dev=1.1.22-r3 \
    openssh=8.0_p1-r0 \
    zlib-dev=1.2.11-r1

include(`sqrl.m4')

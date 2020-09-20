FROM alpine:3.10
ENV LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

ARG KAFKA_CAT_VERSION=1.4.0

RUN apk add --no-cache openssl-dev curl git build-base bash tar wget python yajl yajl-dev cmake coreutils && \
  git clone --branch ${KAFKA_CAT_VERSION} --single-branch https://github.com/edenhill/kafkacat.git kafkacat && \
  cd kafkacat && \
  ./bootstrap.sh && \
  make install && \
  strip /usr/local/bin/kafkacat

FROM alpine:3.10
ENV LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

COPY --from=0 /usr/local/bin/kafkacat /usr/local/bin/kafkacat

RUN apk add --update --no-cache ca-certificates file=5.37-r1 curl=7.66.0-r1 \
    librdkafka=1.0.1-r1 zsh=5.7.1-r0 jq=1.6-r0
RUN mkdir /data /app /lib64 && \
    chmod a+rw /data && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    chmod u+s /bin/ping

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && mv ./kubectl /usr/bin/kubectl && chmod +x /usr/bin/kubectl


COPY atsu-ca.pem /etc/ssl/certs/

WORKDIR /data

ARG VERSION="<not set>"
ARG IMAGE_NAME="<not set>"
ARG USER_ID=1000

ENV ATSU_BASE_IMAGE_NAME="${IMAGE_NAME}"
ENV ATSU_BASE_IMAGE_VERSION="${VERSION}"

USER ${USER_ID}

LABEL atsu-alpine-version="${VERSION}"

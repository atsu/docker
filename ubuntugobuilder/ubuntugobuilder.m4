# Dockerfile is auto-generated via m4 macro processing
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y ca-certificates && apt-get upgrade -u -y
RUN echo deb [trusted=yes] https://repo.iovisor.org/apt/bionic bionic-nightly main | tee /etc/apt/sources.list.d/iovisor.list
RUN apt-get update && apt-get install -y libbcc wget
RUN wget -q https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz && tar -xzf go1.13.1.linux-amd64.tar.gz -C /usr/lib && \
	ln /usr/lib/go/bin/go /usr/bin/go && rm -f go1.13.1.linux-amd64.tar.gz 

include(`sqrl.m4')

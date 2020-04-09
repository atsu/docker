# Dockerfile is auto-generated via m4 macro processing
FROM centos:7

# don't include the v prefix if it's a part of of the version string
ARG GIT_VERSION=2.21.0
ARG GO_VERSION=1.12.5
ARG KAFKA_VERSION=0.11.6

RUN yum -y update && yum clean all
RUN yum -y groupinstall "Development Tools"
RUN yum -y install curl-devel expat-devel openssl-devel zlib-devel which nfs-utils \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    elfutils-libelf-devel cmake3 git bison flex ncurses-devel luajit luajit-devel

# Build/install golang

RUN curl -LO https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz && \
        tar -zxf v${GIT_VERSION}.tar.gz && \
        rm -f v${GIT_VERSION}.tar.gz && \
        pushd git-${GIT_VERSION} && \
        make configure > /dev/null && \
        make install > /dev/null && \
        mv git /usr/bin/git && \
        popd && \
        rm -rf git-${GIT_VERSION} && \
        curl -LO https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
        tar -C /usr/local -xvzf go${GO_VERSION}.linux-amd64.tar.gz > /dev/null && \
        rm -f go${GO_VERSION}.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH /go/bin:/usr/local/go/bin:/usr/bin:/opt/rh/llvm-toolset-7/root/usr/bin
ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig/

# Build/install librdkafka

WORKDIR /root/
RUN git clone -b v${KAFKA_VERSION} https://github.com/edenhill/librdkafka.git
WORKDIR /root/librdkafka
RUN /root/librdkafka/configure --prefix=/usr
RUN make
RUN make install
WORKDIR /root/
RUN rm -rf /root/librdkafka

# Install llvm7

RUN yum update -y
RUN yum install -y centos-release-scl
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum install -y devtoolset-7 llvm-toolset-7 llvm-toolset-7-llvm-devel llvm-toolset-7-llvm-static llvm-toolset-7-clang-devel
RUN yum install -y cmake3
RUN source scl_source enable devtoolset-7 llvm-toolset-7

# Build/install libbpf

RUN curl -L https://github.com/libbpf/libbpf/archive/v0.0.4.tar.gz --output /root/bpf.tar.gz && tar xvf /root/bpf.tar.gz && mv libbpf-0.0.4 bpf && cd /root/bpf/src && make all install && rm -rf /root/bpf

# Build/install libbcc - note pinned to libbpf-0.0.4 && gobpf (b81944f5e466e725c41d59abfabfb552284e43a3)

RUN git clone https://github.com/iovisor/bcc.git && cd bcc && git checkout v0.8.0 && mkdir build && cd build && cmake3 .. -DLLVM_DIR=/opt/rh/llvm-toolset-7/root/usr/lib64/cmake/llvm -DCMAKE_INSTALL_PREFIX=/usr && make all install && rm -rf /root/bcc

# Needed to leverage bcc/bpf

ENV LD_LIBRARY_PATH=/opt/rh/llvm-toolset-7/root/usr/lib64/:/usr/lib

include(`sqrl.m4')

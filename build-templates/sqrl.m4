COPY --from=ghcr.io/atsu/sqrl:SQRL_VERSION /bin/sqrl /bin/

ENV ATSU_BUILDER_TYPE=BUILDER_TYPE
ENV ATSU_BUILDER_VERSION=IMAGE_VERSION

LABEL version="IMAGE_VERSION" builder="BUILDER_TYPE"

VOLUME ["/src", "/dst"]
WORKDIR /src
CMD [ "sh", "-c", "echo $ATSU_BUILDER_VERSION"]

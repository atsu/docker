FROM atsuio/alpine:latest

USER root

# copy curator and necessary libraries
COPY --from=untergeek/curator:5.7.6 /curator/ /curator/
COPY --from=untergeek/curator:5.7.6 /usr/lib/libssl.so.43 /usr/lib/
COPY --from=untergeek/curator:5.7.6 /usr/lib/libcrypto.so.41 /usr/lib/

USER nobody:nobody

ENTRYPOINT ["/curator/curator"]

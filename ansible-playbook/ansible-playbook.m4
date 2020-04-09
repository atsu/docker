FROM atsuio/alpine

USER root

ADD defaults/hosts /etc/ansible/hosts
RUN apk add --no-cache openssh ansible && \
    pip3 install boto awscli && \
    adduser -D -u 1000 atsu && \
    mkdir -m 0700 -p /.ansible /playbook && \
    chown 1000 /playbook /.ansible

ADD --chown=1000 scripts/muts-s3-ansible-playbook.sh /app/muts-s3-ansible-playbook.sh

ARG VERSION="<not set>"
ARG IMAGE_NAME="<not set>"
ARG USER_ID=1000

USER ${USER_ID}
WORKDIR /playbook

LABEL atsu-ansible-playbook-version="${VERSION}"

ENTRYPOINT ["/usr/bin/ansible-playbook"]
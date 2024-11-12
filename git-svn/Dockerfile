FROM youken9980/alpine:3
LABEL maintainer="YangJian <youken9980@163.com>"

ENV GIT_USER_NAME="user.name"
ENV GIT_USER_EMAIL="user.email"

RUN set -eux && \
    apk --update --no-cache add git subversion git-svn openssh-keygen && \
    \
    rm -rf /var/cache/apk/*.*

WORKDIR /root
COPY sshkeygen.sh /root/sshkeygen.sh
COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]

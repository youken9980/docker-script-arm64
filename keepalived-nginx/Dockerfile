FROM youken9980/nginx:stable-alpine-slim
LABEL maintainer="YangJian <youken9980@163.com>"

ENV RUN_KEEPALIVED="false"
ENV KEEPALIVED_INTERFACE="eth0"
ENV KEEPALIVED_STATE="BACKUP"
ENV KEEPALIVED_ROUTER_ID="100"
ENV KEEPALIVED_PRIORITY="150"
ENV KEEPALIVED_PASSWORD="d0cker"
ENV KEEPALIVED_VIRTUAL_IP="172.18.0.100"

RUN set -eux && \
    apk --update --no-cache add which procps busybox-extras ipvsadm keepalived && \
    rm -rf /var/cache/apk/*.*

COPY realServerVip.sh /usr/local/bin/
COPY check-host-port.sh /usr/local/bin/
COPY check-service.sh /usr/local/bin/
COPY notify.sh /usr/local/bin/
COPY keepalived.conf /etc/keepalived/
COPY entrypoint.sh /usr/local/bin/

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

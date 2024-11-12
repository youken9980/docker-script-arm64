FROM mysql:8
LABEL maintainer="YangJian <youken9980@163.com>"

ENV SHELL="/bin/bash"
ENV TZ="Asia/Shanghai"

RUN set -eux && \
    \
    mv /usr/share/zoneinfo/PRC /PRC && \
    rm -rf /usr/share/zoneinfo && \
    mkdir -p /usr/share/zoneinfo/Asia && \
    mv /PRC /usr/share/zoneinfo/PRC && \
    ln -sTf /usr/share/zoneinfo/PRC /usr/share/zoneinfo/Asia/Shanghai && \
    ln -sTf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

STOPSIGNAL SIGTERM

CMD ["/bin/bash"]

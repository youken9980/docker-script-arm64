FROM rust:1-slim
LABEL maintainer="YangJian <youken9980@163.com>"

ARG DEBIAN_MIRROR="deb.debian.org"

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
    echo "Asia/Shanghai" > /etc/timezone && \
    \
    sed -i "s|# export LS_OPTIONS='--color=auto'|export LS_OPTIONS='--color=auto'|g" /root/.bashrc && \
    sed -i 's|# eval "\$(dircolors)"|eval "`dircolors`"|g' /root/.bashrc && \
    sed -i "s|# alias ls='ls \$LS_OPTIONS'|alias ls='ls \$LS_OPTIONS'|g" /root/.bashrc && \
    sed -i "s|# alias ll='ls \$LS_OPTIONS -l'|alias ll='ls \$LS_OPTIONS -la'|g" /root/.bashrc && \
    sed -i "s|# alias l='ls \$LS_OPTIONS -lA'|alias l='ls \$LS_OPTIONS -lA'|g" /root/.bashrc && \
    echo '' >> /root/.bashrc && \
    echo 'export RUSTUP_DIST_SERVER="https://rsproxy.cn"' >> /root/.bashrc && \
    echo 'export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"' >> /root/.bashrc && \
    \
    cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak && \
    sed -i "s|deb.debian.org|${DEBIAN_MIRROR}|g" /etc/apt/sources.list.d/debian.sources && \
    \
    apt-get update && \
    apt-get install --no-install-recommends -y apt-transport-https ca-certificates curl && \
    sed -i "s|http://|https://|g" /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    \
    rm -rf /var/lib/apt/lists/*

COPY ./config /root/.cargo/config

STOPSIGNAL SIGTERM

CMD ["/bin/bash"]

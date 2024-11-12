FROM node:14-alpine
LABEL maintainer="YangJian <youken9980@163.com>"

ARG ALPINE_MIRROR="dl-cdn.alpinelinux.org"

ENV TZ="Asia/Shanghai"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

ENV NPM_CACHE_DIR="/usr/local/repository/npm"
ENV YARN_CACHE_DIR="/usr/local/repository/yarn"

RUN set -eux && \
    \
    sed -i "s|dl-cdn.alpinelinux.org|${ALPINE_MIRROR}|g" /etc/apk/repositories && \
    apk --update --no-cache add tzdata ca-certificates git subversion axel tree rsync && \
    mv /usr/share/zoneinfo/Asia/Shanghai /Shanghai && \
    rm -rf /usr/share/zoneinfo && \
    mkdir -p /usr/share/zoneinfo/Asia && \
    mv /Shanghai /usr/share/zoneinfo/Asia/. && \
    echo "Asia/Shanghai" > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    update-ca-certificates && \
    \
    rm -rf /var/cache/apk/*.* && \
    mkdir -p ${NPM_CACHE_DIR} ${YARN_CACHE_DIR} && \
    \
    npm config set registry=https://mirrors.huaweicloud.com/repository/npm && \
    npm config set disturl=https://mirrors.huaweicloud.com/nodejs && \
    npm config set sass_binary_site=https://mirrors.huaweicloud.com/node-sass && \
    npm config set phantomjs_cdnurl=https://mirrors.huaweicloud.com/phantomjs && \
    npm config set chromedriver_cdnurl=https://mirrors.huaweicloud.com/chromedriver && \
    npm config set operadriver_cdnurl=https://mirrors.huaweicloud.com/operadriver && \
    npm config set electron_mirror=https://mirrors.huaweicloud.com/electron && \
    npm config set python_mirror=https://mirrors.huaweicloud.com/python && \
    npm config set cache ${NPM_CACHE_DIR} && \
    npm cache clean --force && \
    \
    yarn config set registry https://mirrors.huaweicloud.com/repository/npm && \
    yarn config set disturl https://mirrors.huaweicloud.com/nodejs && \
    yarn config set sass_binary_site https://mirrors.huaweicloud.com/node-sass && \
    yarn config set phantomjs_cdnurl https://mirrors.huaweicloud.com/phantomjs && \
    yarn config set chromedriver_cdnurl https://mirrors.huaweicloud.com/chromedriver && \
    yarn config set operadriver_cdnurl https://mirrors.huaweicloud.com/operadriver && \
    yarn config set electron_mirror https://mirrors.huaweicloud.com/electron && \
    yarn config set python_mirror https://mirrors.huaweicloud.com/python && \
    yarn config set cache-folder ${YARN_CACHE_DIR} && \
    yarn config set yarn-offline-mirror ${YARN_CACHE_DIR} && \
    yarn config set yarn-offline-mirror-pruning true && \
    yarn cache clean

VOLUME ["/app","/usr/local/repository/npm","/usr/local/repository/yarn"]

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "node" ]

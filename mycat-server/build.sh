#!/bin/bash
set -eux

source ../.env.docker
rm -rf ${APP_HOME_HOST}

GIT_URL="${GITHUB_MIRROR}/MyCATApache/Mycat-Server.git"
PROJ_SRC="${APP_HOME_CONTAINER}/proj-src"

dockerRunBuild " \
    git clone --depth=1 ${GIT_URL} ${PROJ_SRC} && \
    cd ${PROJ_SRC} && \
    mvn -Dmaven.test.skip=true -T 16 clean compile package && \
    \
    PROJ_VERSION=\$(xpath -q -e '//project/version/text()' ${PROJ_SRC}/pom.xml) && \
    mv ${PROJ_SRC}/target/Mycat-server-\${PROJ_VERSION}-*-linux.tar.gz ${APP_HOME_CONTAINER}/mycat.tar.gz && \
    \
    mkdir -p ${APP_HOME_CONTAINER}/mycat && \
    tar -zxvf ${APP_HOME_CONTAINER}/mycat.tar.gz -C ${APP_HOME_CONTAINER}/mycat --strip-components=1 --no-same-owner && \
    rm -rf ${PROJ_SRC}
"

docker build \
    -f Dockerfile \
    -t youken9980/mycat-server:1.6.7.6 \
    .

rm -rf ${APP_HOME_HOST}

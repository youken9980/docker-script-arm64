#!/bin/bash
set -eux

source ../.env.docker
rm -rf ${APP_HOME_HOST}

# https://gitee.com/kekingcn/file-online-preview.git
# https://github.com/kekingcn/kkFileView.git
GIT_URL="${GITHUB_MIRROR}//kekingcn/kkFileView.git"
PROJ_SRC="${APP_HOME_CONTAINER}/proj-src"
KKFILEVIEW_HOME="${APP_HOME_CONTAINER}/kkFileView"

dockerRunBuild " \
    git clone --depth=1 ${GIT_URL} ${PROJ_SRC} && \
    cd ${PROJ_SRC} && \
    mvn -Dmaven.test.skip=true -T 16 clean compile package && \
    \
    PROJ_VERSION=\$(xpath -q -e '//project/version/text()' ${PROJ_SRC}/pom.xml) && \
    cp ${PROJ_SRC}/server/target/kkFileView-\${PROJ_VERSION}.tar.gz /kkFileView.tar.gz && \
    mkdir -p ${KKFILEVIEW_HOME} && \
    tar -zxvf /kkFileView.tar.gz -C ${KKFILEVIEW_HOME} --strip-components=1 --no-same-owner && \
    mv ${KKFILEVIEW_HOME}/bin/kkFileView-\${PROJ_VERSION}.jar ${KKFILEVIEW_HOME}/bin/kkFileView.jar && \
    rm -rf ${PROJ_SRC}
"

docker build \
    -f Dockerfile \
    -t youken9980/file-online-preview:latest \
    .

rm -rf ${APP_HOME_HOST}

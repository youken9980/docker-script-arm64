#!/bin/bash
set -eux

source ../.env.docker
rm -rf ${APP_HOME_HOST}

GIT_URL="${GITHUB_MIRROR}/MyCATApache/Mycat2.git"
PROJ_SRC="${APP_HOME_CONTAINER}/proj-src"

dockerRunBuild " \
    git clone --depth=1 ${GIT_URL} ${PROJ_SRC} && \
    cd ${PROJ_SRC} && \
    mvn -Dmaven.test.skip=true -T 16 clean compile package -pl mycat2 -am && \
    mv ${PROJ_SRC}/mycat2/src/main/resources ${APP_HOME_CONTAINER}/mycat && \
    \
    PROJ_VERSION=\$(xpath -q -e '//project/version/text()' ${PROJ_SRC}/pom.xml) && \
    mv ${PROJ_SRC}/mycat2/target/mycat2-\${PROJ_VERSION}-jar-with-dependencies.jar ${APP_HOME_CONTAINER}/mycat/mycat2.jar && \
    rm -rf ${PROJ_SRC}
"

docker build \
    -f Dockerfile \
    -t youken9980/mycat2:1.22 \
    .

rm -rf ${APP_HOME_HOST}

#!/bin/bash
set -eux

source ../.env.docker
rm -rf ${APP_HOME_HOST}

GIT_URL="${GITHUB_MIRROR}/NipGeihou/JrebelLicenseServerforJava.git"
PROJ_SRC="${APP_HOME_CONTAINER}/proj-src"

dockerRunBuild " \
    git clone --depth=1 ${GIT_URL} ${PROJ_SRC} && \
    cd ${PROJ_SRC} && \
    mvn -Dmaven.test.skip=true -T 16 clean compile package && \
    \
    PROJ_VERSION=\$(xpath -q -e '//project/version/text()' ${PROJ_SRC}/pom.xml) && \
    cp ${PROJ_SRC}/target/JrebelBrainsLicenseServerforJava-\${PROJ_VERSION}-jar-with-dependencies.jar ${APP_HOME_CONTAINER}/service.jar && \
    rm -rf ${PROJ_SRC}
"

docker build \
    --build-arg "SERVER_PORT=8080" \
    -f Dockerfile \
    -t youken9980/jrebel-ls:latest \
    .

rm -rf ${APP_HOME_HOST}

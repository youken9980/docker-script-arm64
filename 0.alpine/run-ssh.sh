#!/bin/bash

imageTag="youken9980/openssh-server:alpine"
network="mynet"

function dockerRm() {
    filter="$1"
    containerId=$(docker ps -aq --filter "${filter}")
    runningContainerId=$(docker ps -aq --filter status=running --filter $1)
    if [ "${runningContainerId}" != "" ]; then
        docker stop ${runningContainerId}
    fi
    if [ "${containerId}" != "" ]; then
        docker rm ${containerId}
    fi
}

dockerRm "ancestor=${imageTag}"
docker run -d -p 22:22 --network="${network}" "${imageTag}"
docker exec -it $(docker ps -aq --filter ancestor="${imageTag}") /bin/sh

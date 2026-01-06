#!/bin/bash

imageTag="youken9980/funasr:offline-0.4.7"
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
docker run --platform linux/amd64 -it -d -p 10095:10095 --privileged=true \
  -v /Volumes/raid0/gpt/funasr-runtime-resources/models:/workspace/models \
  --name funasr-offline --network="${network}" "${imageTag}"
docker exec -it funasr-offline bash

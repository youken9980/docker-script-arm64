#!/bin/bash

imageTag="youken9980/mycat2:1.22"
containerName="mycat2"
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

function dockerLogsUntil() {
    filter="$1"
    endpoint="$2"
    containerId=$(docker ps -aq --filter "${filter}")
    nohup docker logs -f "${containerId}" > "/tmp/${containerId}.log" 2>&1 &
    sleep 1s
    PID=$(ps aux | grep "docker" | grep ${containerId} | awk '{print $2}' | sort -nr | head -1)
    if [ "${PID}" != "" ]; then
        eval "tail -n 1 -f --pid=${PID} /tmp/${containerId}.log | sed '/${endpoint}/q'"
        kill -9 ${PID}
        rm /tmp/${containerId}.log
    fi
}

dockerRm "name=${containerName}"
docker run --privileged -d -p 8066:8066 \
    --cpus 2 --memory 3072M --memory-swap -1 \
    -v $(pwd)/prototypeDs.datasource.json:/mycat/datasources/prototypeDs.datasource.json \
    --network="${network}" --name="${containerName}" \
    "${imageTag}"
dockerLogsUntil "name=${containerName}" "[[:space:]]started[[:space:]]up."

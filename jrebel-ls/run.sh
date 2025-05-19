#!/bin/bash

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

imageTag="youken9980/jrebel-ls:latest"
containerName="jrebel-ls"
serverPort="8080"
network="mynet"
startSuccessTag="{guid}(eg:http:"

dockerRm "name=${containerName}"
docker run -d -p 127.0.0.1:8079:${serverPort} --restart always \
    --cpus 0.5 --memory 32M --memory-swap -1 \
    --network="${network}" --name="${containerName}" "${imageTag}"
dockerLogsUntil "name=${containerName}" "${startSuccessTag}"

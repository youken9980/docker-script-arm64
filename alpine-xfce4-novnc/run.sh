#!/bin/bash

imageTag="youken9980/alpine-xfce4-novnc:latest"
containerName="alpine-xfce4-novnc"
network="mynet"
vncPort="5900"
novncPort="6080"
vncResolution="1440x900"
vncPasswd="alpinelinux"

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
docker run --privileged -d \
    --cpus 1 --memory 512M --memory-swap -1 \
    -p ${vncPort}:${vncPort} \
    -p ${novncPort}:${novncPort} \
    -e VNC_PORT=${vncPort} \
    -e NOVNC_PORT=${novncPort} \
    -e VNC_RESOLUTION=${vncResolution} \
    -e VNC_PASSWD=${vncPasswd} \
    --network="${network}" --name="${containerName}" \
    "${imageTag}"
dockerLogsUntil "name=${containerName}" "The[[:space:]]VNC[[:space:]]desktop[[:space:]]is"

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

imageTag="youken9980/registry:2"
containerName="dockeregistry"
serverPort="15000"
network="mynet"
startSuccessTag="listening[[:space:]]on[[:space:]]"

htpasswd -nbB "admin" "nimdanimda" | tee $(pwd)/htpasswd
dockerRm "name=${containerName}"
docker run -d -p 15000:${serverPort} --restart always \
    -e "REGISTRY_AUTH=htpasswd" \
    -e "REGISTRY_AUTH_HTPASSWD_REALM=basic-realm" \
    -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
    -e "REGISTRY_HTTP_ADDR=:15000" \
    -e "REGISTRY_HTTP_HOST=http://dockeregistry.localhost:15000" \
    -e "REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/data" \
    -v ~/dockerVolume/registry/data:/data \
    -v $(pwd)/htpasswd:/auth/htpasswd \
    --network="${network}" --name="${containerName}" "${imageTag}"
dockerLogsUntil "name=${containerName}" "${startSuccessTag}"

# /etc/docker/registry/config.yml

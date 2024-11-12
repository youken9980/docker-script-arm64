#!/bin/bash

imageTag="youken9980/file-online-preview:latest"
containerName="file-online-preview"
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
docker run -d -p 127.0.0.1:8012:8012 \
    --cpus 1 --memory 384M --memory-swap -1 \
    -e KK_OFFICE_PREVIEW_SWITCH_DISABLED="true" \
    -e KK_OFFICE_PREVIEW_TYPE="pdf" \
    -e WATERMARK_TXT="才华有限公司" \
    -e WATERMARK_ALPHA="0.1" \
    --network="${network}" --name="${containerName}" \
    "${imageTag}"
dockerLogsUntil "name=${containerName}" "kkFileView[[:space:]]服务启动完成"

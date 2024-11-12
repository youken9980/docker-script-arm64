#!/bin/bash

imageTag="youken9980/keepalived-nginx:1.22-alpine"
containerNamePrefix="nginx"
network="mynet"
nodeCount=2
startPort="8090"
publishPort="first"
keepalivedRouterId="209"
keepalivedVirtualIp="172.18.0.209"
runKeepalived="true"
runWithSSL="false"

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

publishSSL=""
volumeList=""
if [ "${runWithSSL}" = "true" ]; then
    nodeCount=1
    startPort="80"
    publishPort="true"
    publishSSL="--expose 443 -p 443:443"
    volumeList="-v $(pwd)/default-ssl.conf:/etc/nginx/conf.d/default.conf -v $(pwd)/ssl/server.crt:/etc/nginx/ssl/server.crt -v $(pwd)/ssl/server.key:/etc/nginx/ssl/server.key"
fi

for i in $(seq ${nodeCount}); do
    containerName="${containerNamePrefix}-${i}"
    dockerRm "name=${containerName}"
done

port="${startPort}"
for i in $(seq ${nodeCount}); do
    publish=""
    if [ "${publishPort}" = "first" -a "${port}" = "${startPort}" -o "${publishPort}" = "true" ]; then
        publish="-p ${port}:80"
    fi
    containerName="${containerNamePrefix}-${i}"
    docker run --privileged -d ${publish} \
        --cpus 0.1 --memory 32M --memory-swap -1 \
        -e RUN_KEEPALIVED="${runKeepalived}" \
        -e KEEPALIVED_ROUTER_ID="${keepalivedRouterId}" \
        -e KEEPALIVED_VIRTUAL_IP="${keepalivedVirtualIp}" \
        ${publishSSL} ${volumeList} \
        --network="${network}" --name="${containerName}" \
        "${imageTag}"
    if [ "${runKeepalived}" = "true" ]; then
        dockerLogsUntil "name=${containerName}" "VRRP_Script(check-service)[[:space:]]succeeded"
    else
        dockerLogsUntil "name=${containerName}" "[[:space:]]ready[[:space:]]for[[:space:]]start[[:space:]]up"
    fi
    port=$[$port + 1]
done

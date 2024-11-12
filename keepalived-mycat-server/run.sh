#!/bin/bash

imageTag="youken9980/keepalived-mycat-server:1.6.7.6"
containerNamePrefix="mycat-server"
network="mynet"
nodeCount=2
startPort="8066"
publishPort="first"
keepalivedRouterId="199"
keepalivedVirtualIp="172.18.0.199"
runKeepalived="true"

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

for i in $(seq ${nodeCount}); do
    containerName="${containerNamePrefix}-${i}"
    dockerRm "name=${containerName}"
done

port="${startPort}"
for i in $(seq ${nodeCount}); do
    publish=""
    if [ "${publishPort}" = "first" -a "${port}" = "${startPort}" -o "${publishPort}" = "true" ]; then
        publish="-p ${port}:8066"
    fi
    containerName="${containerNamePrefix}-${i}"
    docker run --privileged -d ${publish} \
        --cpus 2 --memory 3072M --memory-swap -1 \
        -e RUN_KEEPALIVED="${runKeepalived}" \
        -e KEEPALIVED_ROUTER_ID="${keepalivedRouterId}" \
        -e KEEPALIVED_VIRTUAL_IP="${keepalivedVirtualIp}" \
        -v ~/dockerScripts/ycg/docker/config/2.mycat-server.xml:/mycat/conf/server.xml \
        -v ~/dockerScripts/ycg/docker/config/2.mycat-schema.xml:/mycat/conf/schema.xml \
        -v ~/dockerScripts/ycg/docker/config/2.mycat-rule.xml:/mycat/conf/rule.xml \
        --network="${network}" --name="${containerName}" \
        "${imageTag}"
    if [ "${runKeepalived}" = "true" ]; then
        dockerLogsUntil "name=${containerName}" "VRRP_Script(check-service)[[:space:]]succeeded"
    else
        dockerLogsUntil "name=${containerName}" "MyCAT[[:space:]]Server[[:space:]]startup[[:space:]]successfully"
    fi
    port=$[$port + 1]
done

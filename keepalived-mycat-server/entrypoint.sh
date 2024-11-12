#!/bin/bash

set -eux

syslogConfig="/etc/syslog.conf"
keepalivedLog="/var/log/keepalived.log"
keepalivedConfig="/etc/keepalived/keepalived.conf"
keepalivedCmd="keepalived -f ${keepalivedConfig} --log-facility=0 --dont-fork --dump-conf --log-detail --log-console"

function rebuid() {
    path=$1
    if [ -e "${path}" ]; then
        rm -rf "${path}"
    fi
    mkdir -p "${path}"
}

function rmPid() {
    file=$1
    if [ -e "${file}" ]; then
        rm "${file}"
    fi
}

rebuid /run/keepalived
rmPid /run/syslogd.pid
rmPid /mycat/logs/mycat.pid

/usr/local/bin/realServerVip.sh start
mycat start
sleep 2s
tail -n +1 /mycat/logs/wrapper.log | sed '/MyCAT[[:space:]]Server[[:space:]]startup[[:space:]]successfully/q'

if [ "${RUN_KEEPALIVED}" = "true" ]; then
    echo "local0.* ${keepalivedLog}" >> "${syslogConfig}"
    syslogd -f "${syslogConfig}"

    counter="$(grep '{{ KEEPALIVED_INTERFACE }}' ${keepalivedConfig} | wc -l)"
    if [ "${counter}" != "0" ]; then
        sed -i "s|{{ KEEPALIVED_INTERFACE }}|$KEEPALIVED_INTERFACE|g" "${keepalivedConfig}"
        sed -i "s|{{ KEEPALIVED_STATE }}|$KEEPALIVED_STATE|g" "${keepalivedConfig}"
        sed -i "s|{{ KEEPALIVED_ROUTER_ID }}|$KEEPALIVED_ROUTER_ID|g" "${keepalivedConfig}"
        sed -i "s|{{ KEEPALIVED_PRIORITY }}|$KEEPALIVED_PRIORITY|g" "${keepalivedConfig}"
        sed -i "s|{{ KEEPALIVED_PASSWORD }}|$KEEPALIVED_PASSWORD|g" "${keepalivedConfig}"
        sed -i "s|{{ KEEPALIVED_VIRTUAL_IP }}|$KEEPALIVED_VIRTUAL_IP|g" "${keepalivedConfig}"
    fi

    eval "${keepalivedCmd}"
else
    tail -n +1 -f /mycat/logs/mycat.log
fi

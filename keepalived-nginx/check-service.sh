#!/bin/sh

serviceName="Nginx"
cmdCheck="ps aux --no-heading | grep 'nginx' | grep 'master' | grep -v '<defunct>' | wc -l"
cmdStartService="nginx -c /etc/nginx/nginx.conf"
cmdStopKeepalived="ps -C keepalived --no-heading | head -1 | awk '{ print$1 }' | xargs kill -9"
counter="$(eval ${cmdCheck})"
if [ "${counter}" = "0" ]; then
    echo "Starting ${serviceName}..."
    eval "${cmdStartService}"
    sleep 2
    counter="$(eval ${cmdCheck})"
    if [ "${counter}" = "0" ]; then
        echo "Start ${serviceName} failed, kill keepalived."
        eval "${cmdStopKeepalived}"
    else
        echo "${serviceName} started."
    fi
fi

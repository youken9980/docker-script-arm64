#!/bin/sh

serviceName="mycat2"
cmdCheck="ps -ef | grep 'java' | grep '/mycat/mycat2.jar' | wc -l"
cmdStartService="nohup java -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -DMYCAT_HOME=${MYCAT_HOME} -jar ${MYCAT_HOME}/mycat2.jar >> /mycat/logs/mycat.log 2>&1 &"
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

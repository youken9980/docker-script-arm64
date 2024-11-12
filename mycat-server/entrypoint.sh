#!/bin/bash

set -eux

pidFile="/mycat/logs/mycat.pid"
if [ -e "${pidFile}" ]; then
    rm "${pidFile}"
fi

mycat start
sleep 2s
tail -n +1 /mycat/logs/wrapper.log | sed '/MyCAT[[:space:]]Server[[:space:]]startup[[:space:]]successfully/q'
tail -n +1 -f /mycat/logs/mycat.log

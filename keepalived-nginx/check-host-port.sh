#!/bin/sh

HOST=$1
PORT=$2
if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "  $0 [HOST|DOMAIN] [PORT]"
    echo ""
    echo "Examples:"
    echo "  $0 localhost 80"
    echo "  $0 192.168.1.1 80"
    exit
fi

nc -v -z "${HOST}" "${PORT}"

#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "DEBIAN_MIRROR=${DEBIAN_MIRROR}" \
    --build-arg "KEYSERVER=${KEYSERVER}" \
    --platform linux/x86_64 \
    -f Dockerfile-5 \
    -t youken9980/mysql:5-debian \
    .

#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "DEBIAN_MIRROR=${DEBIAN_MIRROR}" \
    --build-arg "KEYSERVER=${KEYSERVER}" \
    --platform linux/amd64 \
    -f Dockerfile-5-amd64 \
    -t youken9980/mysql:5-debian \
    .

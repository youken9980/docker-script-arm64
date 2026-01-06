#!/bin/bash

source ../.env.docker

docker build --platform linux/amd64 \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    -f Dockerfile-offline \
    -t youken9980/funasr:offline-0.4.7 \
    .

#!/bin/bash

source ../.env.docker

docker build --platform linux/amd64 \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    -f Dockerfile-online \
    -t youken9980/funasr:online-0.1.13 \
    .

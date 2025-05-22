#!/bin/bash

source ../.env.docker

docker build \
    --platform linux/amd64 \
    --build-arg "ALPINE_MIRROR=${ALPINE_MIRROR}" \
    -f Dockerfile-compiler \
    -t youken9980/dify-compiler:latest \
    .

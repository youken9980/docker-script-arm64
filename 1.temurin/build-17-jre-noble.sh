#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    -f Dockerfile-17-jre-noble \
    -t youken9980/temurin:17-jre-noble \
    .

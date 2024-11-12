#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    -f Dockerfile \
    -t youken9980/ubuntu:noble \
    .

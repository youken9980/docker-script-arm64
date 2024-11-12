#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "GITHUB_MIRROR=${GITHUB_MIRROR}" \
    -f Dockerfile-glibc \
    -t youken9980/alpine:3-glibc \
    .

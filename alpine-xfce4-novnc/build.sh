#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "GITHUB_MIRROR=${GITHUB_MIRROR}" \
    -f Dockerfile \
    -t youken9980/alpine-xfce4-novnc:latest \
    .

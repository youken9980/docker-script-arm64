#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    --build-arg "APACHE_MIRROR=${APACHE_MIRROR}" \
    --build-arg "GITHUB_MIRROR=${GITHUB_MIRROR}" \
    -f Dockerfile-temurin8 \
    -t youken9980/build-tools-temurin8:latest \
    .

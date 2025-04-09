#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "DEBIAN_MIRROR=${DEBIAN_MIRROR}" \
    -f Dockerfile \
    -t youken9980/rust:1-slim \
    .

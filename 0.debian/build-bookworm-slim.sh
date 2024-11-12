#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "DEBIAN_MIRROR=${DEBIAN_MIRROR}" \
    -f Dockerfile-bookworm-slim \
    -t youken9980/debian:bookworm-slim \
    .

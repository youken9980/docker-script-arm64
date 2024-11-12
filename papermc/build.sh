#!/bin/bash

source ../.env.docker

docker build \
    -f Dockerfile \
    -t youken9980/papermc:1.21.1-131 \
    .

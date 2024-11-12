#!/bin/bash

source ../.env.docker

docker build \
    -f Dockerfile \
    -t youken9980/mysql:8 \
    .

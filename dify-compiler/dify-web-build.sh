#!/bin/bash

docker build \
    --platform linux/amd64 \
    -f $(realpath ./Dockerfile-prod) \
    -t youken9980/dify-web-eo:1.4.1 \
    .

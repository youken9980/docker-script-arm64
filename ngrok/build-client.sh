#!/bin/bash

docker build \
    --build-arg NGROK_DOMAIN="ngrok.me" \
    -f Dockerfile-client \
    -t youken9980/ngrok:1.7.1-client \
    .

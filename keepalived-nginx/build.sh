#!/bin/bash

docker build \
    -f Dockerfile \
    -t youken9980/keepalived-nginx:stable-alpine-slim \
    .

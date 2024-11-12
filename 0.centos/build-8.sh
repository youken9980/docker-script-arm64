#!/bin/bash

source ../.env.docker

docker build \
    -f Dockerfile-8 \
    -t youken9980/centos:8 \
    .

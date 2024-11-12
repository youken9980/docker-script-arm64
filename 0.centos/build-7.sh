#!/bin/bash

source ../.env.docker

docker build \
    -f Dockerfile-7 \
    -t youken9980/centos:7 \
    .

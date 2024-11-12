#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "UBUNTU_MIRROR=${UBUNTU_MIRROR}" \
    -f Dockerfile-9-jre8-temurin-noble \
    -t youken9980/tomcat:9-jre8-temurin-noble \
    .

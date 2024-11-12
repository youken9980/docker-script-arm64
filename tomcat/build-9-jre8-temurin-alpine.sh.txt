#!/bin/bash

source ../.env.docker

docker build \
    --build-arg "APACHE_MIRROR=${APACHE_MIRROR}" \
    -f Dockerfile-9-jre8-temurin-alpine \
    -t youken9980/tomcat:9-jre8-temurin-alpine \
    .

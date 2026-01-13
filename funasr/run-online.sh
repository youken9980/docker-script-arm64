#!/bin/bash

imageTag="youken9980/funasr:online-0.1.13"
containerName="funasr-online"

docker rm -f ${containerName}
docker run --platform linux/amd64 -it -d -p 10096:10095 --privileged=true \
  -v /Volumes/raid0/gpt/funasr-runtime-resources/models:/workspace/models \
  --name ${containerName} "${imageTag}"
# docker exec -it ${containerName} bash

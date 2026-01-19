#!/bin/bash

imageTag="youken9980/funasr:offline-0.4.7"
containerName="funasr-offline"

docker rm -f ${containerName}
docker run --platform linux/amd64 -it -d -p 10095:10095 --privileged=true \
  -v ~/Destiny/Share/llm/funasr-runtime-resources:/workspace/models \
  --name ${containerName} "${imageTag}"
# docker exec -it ${containerName} bash

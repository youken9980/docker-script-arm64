#!/bin/bash

rm -rf $(pwd)/app
mkdir -p $(pwd)/app
docker run -it --rm \
    -v $(pwd)/app:/app \
    -v $(pwd)/dify-web-eo-1.3.1:/dify-web-eo-1.3.1 \
    -v $(realpath ./compile-cmd.txt):/compile-cmd.txt \
    youken9980/dify-compiler:latest

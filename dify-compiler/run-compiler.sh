#!/bin/bash

rm -rf $(pwd)/app
mkdir -p $(pwd)/app
docker run -it --rm \
    -v $(pwd)/app:/app \
    -v $(pwd)/dify-web-eo:/dify-web-eo \
    -v $(realpath ./compile-cmd.txt):/compile-cmd.txt \
    youken9980/dify-compiler:latest

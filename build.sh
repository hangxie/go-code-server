#!/usr/bin/env bash

set -euo pipefail

docker pull codercom/code-server:latest

docker context ls | grep multi-platform > /dev/null || \
    (
        docker context create multi-platform;
        docker buildx create multi-platform --platform linux/amd64,linux/arm64 --use
    )
docker buildx build \
    --progress plain \
    --push \
    --build-arg GO_VERSION=$1 \
    --platform linux/amd64,linux/arm64 \
    -t hangxie/go-code-server:$1 \
    -t hangxie/go-code-server:$(echo $1 | cut -f 1-2 -d .) \
    -t hangxie/go-code-server:latest \
    .

#!/usr/bin/env bash

set -euo pipefail

GO_VERSION=$1
PUBLISH_LATEST=${2:-yes}
if [ "${PUBLISH_LATEST}" == "yes" ]; then
    EXTRA_FLAG="-t hangxie/go-code-server:latest"
else
    EXTRA_FLAG=""
fi

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
    ${EXTRA_FLAG} \
    .

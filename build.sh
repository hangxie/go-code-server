#!/usr/bin/bash

set -euo pipefail

docker build -t hangxie/go-code-server:$1 --build-arg GO_VERSION=$1 .
docker tag hangxie/go-code-server:$1 hangxie/go-code-server:$(echo $1 | cut -f 1-2 -d .)
docker tag hangxie/go-code-server:$1 hangxie/go-code-server:latest

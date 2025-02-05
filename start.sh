#!/usr/bin/bash

set -euo pipefail

VERSION=${1:-latest}

docker run -d --rm --name go-code-server \
    -p 127.0.0.1:8080:8080 \
    -v "$HOME/.config:/home/coder/.config" \
    -v "$HOME/dev:/home/coder/project" \
    -u "$(id -u):$(id -g)" \
    -e "DOCKER_USER=$USER" \
    hangxie/go-code-server:${VERSION}

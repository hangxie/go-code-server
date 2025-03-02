#!/usr/bin/bash

set -euo pipefail

VERSION=${1:-latest}

# you want to start a tmux/screen session for ssh agent session
# eval `ssh-agent`
# ssh-add
docker run -it --rm --name go-code-server \
    -p 127.0.0.1:8080:8080 \
    -v "$HOME/.config:/home/coder/.config" \
    -v "$HOME/dev:/home/coder/project" \
    -v "$SSH_AUTH_SOCK:/home/coder/.ssh/$(basename $SSH_AUTH_SOCK)" \
    -u "$(id -u):$(id -g)" \
    -e "DOCKER_USER=$USER" \
    -e "SSH_AUTH_SOCK=/home/coder/.ssh/$(basename $SSH_AUTH_SOCK)" \
    hangxie/go-code-server:${VERSION}

FROM codercom/code-server:latest

USER root

ARG GO_VERSION

RUN test "${GO_VERSION}" || (echo Please set GO_VERSION && false) \
 && case "$(uname -m)" in \
        x86_64) ARCH=amd64 ;; \
        aarch64) ARCH=arm64 ;; \
        *) echo not supported; false ;; \
    esac \
 && DEBIAN_FRONTEND=noninteractive \
 && apt-get update -qq \
 && apt-get dist-upgrade -y -qq \
 && apt-get install -y -qq build-essential \
 && cd /tmp \
 && wget --quiet https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz \
 && cd /usr/local \
 && tar zxf /tmp/go${GO_VERSION}.linux-${ARCH}.tar.gz \
 && rm /tmp/go${GO_VERSION}.linux-${ARCH}.tar.gz \
 && ln -fns /usr/local/go/bin/* /usr/local/bin/ \
 && su coder -c "code-server --install-extension golang.go" \
 && su coder -c "go install golang.org/x/tools/gopls@latest" \
 && su coder -c "go install github.com/cweill/gotests/gotests@latest" \
 && su coder -c "go install github.com/fatih/gomodifytags@latest" \
 && su coder -c "go install github.com/josharian/impl@latest" \
 && su coder -c "go install github.com/haya14busa/goplay/cmd/goplay@latest" \
 && su coder -c "go install github.com/go-delve/delve/cmd/dlv@latest" \
 && su coder -c "go install honnef.co/go/tools/cmd/staticcheck@latest" \
 && apt-get clean

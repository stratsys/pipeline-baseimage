FROM docker.io/node:lts-alpine3.17

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam && \
    apk add bash=5.1.16-r2 sudo=1.9.12_p2-r0 shadow=4.13-r2 jq=1.6-r1 && \
    apk del .pipeline-deps
RUN apk add --no-cache curl openssl docker-cli git openssh-client yq

# Resolve Dependencies [trivy]
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.45.0

# Resolve Dependencies [Helm]
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | DESIRED_VERSION=v3.13.0 bash

# Resolve Dependencies [kubectl]
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/v1.28.5/bin/linux/amd64/kubectl" && \
    curl -o /usr/local/bin/kubectl.sha256 -L "https://dl.k8s.io/release/v1.28.5/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat /usr/local/bin/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - && \
    chmod +x /usr/local/bin/kubectl

# Add Helper script [git-go]
COPY src/git-go    /bin/
COPY src/common.sh /bin/

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"
CMD [ "/bin/bash" ]

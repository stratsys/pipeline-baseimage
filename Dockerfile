FROM docker.io/node:lts-alpine3.17

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam && apk add bash sudo shadow jq && apk del .pipeline-deps
RUN apk add --no-cache curl openssl docker-cli git openssh-client yq

# Resolve Dependencies [trivy]
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3

# Resolve Dependencies [Helm]
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | DESIRED_VERSION=v3.16.2 bash

# Resolve Dependencies [kubectl]
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/v1.28.5/bin/linux/amd64/kubectl" && chmod +x /usr/local/bin/kubectl

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"
CMD [ "/bin/bash" ]

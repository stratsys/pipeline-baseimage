FROM node:17.1-alpine3.14

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow \
  && apk del .pipeline-deps
RUN apk add --no-cache curl openssl docker-cli
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.21.1
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/v1.22.4/bin/linux/amd64/kubectl" && chmod +x /usr/local/bin/kubectl
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | DESIRED_VERSION=v3.7.1 bash 
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

CMD [ "/bin/bash" ]

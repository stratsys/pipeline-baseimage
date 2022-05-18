FROM docker.io/node:18-alpine3.15

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow jq sed \
  && apk del .pipeline-deps
RUN wget -O /usr/bin/yq https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 && chmod +x /usr/bin/yq
RUN apk add --no-cache curl openssl docker-cli git
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.21.1
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/v1.22.4/bin/linux/amd64/kubectl" && chmod +x /usr/local/bin/kubectl
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | DESIRED_VERSION=v3.8.1 bash 
RUN mkdir -p /root/.helm/plugins
RUN helm plugin install https://github.com/chartmuseum/helm-push.git

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

CMD [ "/bin/bash" ]

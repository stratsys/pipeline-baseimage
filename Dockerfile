#FROM docker.io/library/docker:stable-dind
#RUN apk add bash sudo shadow
#ENTRYPOINT ["/bin/sh","-c"]
#CMD ["/bin/bash"]
#FROM registry.proxy.office.stratsys.net/docker-io/library/docker:stable-dind
#registry.proxy.office.stratsys.net/library/pipeline-baseimage:latest

FROM node:10-alpine

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow \
  && apk del .pipeline-deps \
  && apk add docker-cli

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

CMD [ "node" ]

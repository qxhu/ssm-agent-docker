FROM alpine:latest

RUN apk add --no-cache rpm2cpio cpio curl wget

WORKDIR /ssm
ADD install_agent.sh /tmp/install_agent.sh

ENTRYPOINT /tmp/install_agent.sh
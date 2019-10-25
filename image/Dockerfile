FROM alpine:3.9

# Install common Dojo scripts
ENV DOJO_VERSION=0.6.2
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache tini bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

ENV AWS_CLI_VERSION=1.16.238 BOTO3_VERSION=1.9.228 ECS_CLI_VERSION=1.7.0
RUN apk add --no-cache make python py-pip curl groff &&\
  pip install awscli==${AWS_CLI_VERSION} boto3==${BOTO3_VERSION}

# Install the AWS ECS CLI
RUN sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-v${ECS_CLI_VERSION}
RUN sudo chmod +x /usr/local/bin/ecs-cli

# Install jq to parse json in bash
RUN wget -O ./jq-linux64 https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

# Install saml2aws - it's the most robust tool of this type
RUN wget -O saml2aws.tar.gz \
 https://github.com/Versent/saml2aws/releases/download/v2.17.0/saml2aws_2.17.0_linux_amd64.tar.gz &&\
 tar xf saml2aws.tar.gz &&\
 chmod +x saml2aws &&\
 mv saml2aws /usr/bin

# Install aws-nuke
RUN wget -O aws-nuke \
  https://github.com/rebuy-de/aws-nuke/releases/download/v2.12.0/aws-nuke-v2.12.0-linux-amd64 &&\
  chmod +x aws-nuke &&\
  mv aws-nuke /usr/bin/

# pretty bash prompt
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo /home/dojo/.bashrc /home/dojo/.profile

COPY inputrc /etc/inputrc
COPY etc_dojo.d /etc/dojo.d

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

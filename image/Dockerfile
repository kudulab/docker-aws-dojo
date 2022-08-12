FROM alpine:3.15

# Install common Dojo scripts
ENV DOJO_VERSION=0.10.5
RUN apk add --no-cache tini bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

# Install aws cli version 2 (validate the files using the PGP signature)
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
# It does not work by default on Alpine Linux, thus we need glibc to fix it:
# https://github.com/aws/aws-cli/issues/4685#issuecomment-615872019
RUN apk add --no-cache unzip gnupg nano
COPY aws.gpg /opt/aws.gpg
ENV GLIBC_VER=2.31-r0
RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk &&\
  curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.4.19.zip.sig &&\
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.4.19.zip" -o "awscliv2.zip" &&\
  gpg --import /opt/aws.gpg &&\
  gpg --verify awscliv2.sig awscliv2.zip &&\
  unzip awscliv2.zip &&\
  ./aws/install

# groff less are needed to read aws cli help
ENV BOTO3_VERSION=1.21.3 ECS_CLI_VERSION=1.20.0
RUN apk add --no-cache make python3 py3-pip curl groff less &&\
  pip3 install boto3==${BOTO3_VERSION}

# Install the AWS ECS CLI
RUN sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-v${ECS_CLI_VERSION}
RUN sudo chmod +x /usr/local/bin/ecs-cli

# Install jq to parse json in bash
RUN wget -O ./jq-linux64 https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

# Install saml2aws - it's the most robust tool of this type
RUN wget -O saml2aws.tar.gz \
 https://github.com/Versent/saml2aws/releases/download/v2.27.1/saml2aws_2.27.1_linux_amd64.tar.gz &&\
 tar xf saml2aws.tar.gz &&\
 chmod +x saml2aws &&\
 mv saml2aws /usr/bin

# Install aws-nuke
RUN wget \
  https://github.com/rebuy-de/aws-nuke/releases/download/v2.19.0/aws-nuke-v2.19.0-linux-amd64.tar.gz &&\
  tar xf aws-nuke-v2.19.0-linux-amd64.tar.gz &&\
  chmod +x aws-nuke-v2.19.0-linux-amd64 &&\
  mv aws-nuke-v2.19.0-linux-amd64 /usr/bin/aws-nuke

# pretty bash prompt
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo /home/dojo/.bashrc /home/dojo/.profile

COPY inputrc /etc/inputrc
COPY etc_dojo.d /etc/dojo.d

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

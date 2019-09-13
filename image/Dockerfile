FROM alpine:3.9

# Install common Dojo scripts
ENV DOJO_VERSION=0.6.0
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache tini bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

ENV AWS_CLI_VERSION=1.16.238 BOTO3_VERSION=1.9.228
RUN apk add --no-cache python py-pip &&\
  pip install awscli==${AWS_CLI_VERSION} boto3==${BOTO3_VERSION}

# install jq to parse json in bash
RUN wget -O ./jq-linux64 https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 &&\
  chmod +x ./jq-linux64 &&\
  mv ./jq-linux64 /usr/bin/jq

# pretty bash prompt
COPY bashrc /home/dojo/.bashrc
COPY profile /home/dojo/.profile
RUN chown dojo:dojo /home/dojo/.bashrc /home/dojo/.profile

COPY inputrc /etc/inputrc
COPY etc_dojo.d /etc/dojo.d

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

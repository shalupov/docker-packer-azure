FROM ubuntu:14.04
MAINTAINER lukewpatterson

ENV REFRESHED_AT 2015-09-30

ENV PACKER_BIN_DIR /packer/bin
ENV PACKER_FILES_DIR /packer/files
RUN mkdir --parents $PACKER_BIN_DIR \
  && mkdir --parents $PACKER_FILES_DIR

RUN apt-get update --yes \
  && apt-get install --yes wget unzip software-properties-common python-software-properties

WORKDIR $PACKER_BIN_DIR
ENV PACKER_DOWNLOAD packer_0.7.5_linux_amd64.zip
RUN wget -nv https://dl.bintray.com/mitchellh/packer/$PACKER_DOWNLOAD \
  && unzip -q $PACKER_DOWNLOAD \
  && rm $PACKER_DOWNLOAD
ENV PATH $PATH:$PACKER_BIN_DIR

ENV HOME /root
ENV GOPATH $HOME/go
ENV PATH $PATH:$GOPATH/bin
RUN add-apt-repository ppa:evarlast/golang1.4 \
  && apt-get update \
  && apt-get install --yes golang git mercurial \
  && mkdir --parents $HOME/go \
  && go get github.com/MSOpenTech/packer-azure/packer/plugin/... \
  && mv $GOPATH/bin/* $PACKER_BIN_DIR

# see https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
RUN add-apt-repository ppa:chris-lea/node.js \
  && apt-get update \
  && apt-get install --yes nodejs

RUN npm install --global azure-cli \
  && apt-get install --yes bash-completion \
  && azure --completion >> ~/azure.completion.sh \
  && echo 'source ~/azure.completion.sh' >> ~/.bashrc


WORKDIR $PACKER_FILES_DIR
CMD /bin/bash

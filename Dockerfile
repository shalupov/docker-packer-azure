FROM ubuntu:14.04

ENV PACKER_BIN_DIR=/packer/bin
ENV PACKER_FILES_DIR=/packer/files
RUN mkdir --parents $PACKER_BIN_DIR \
  && mkdir --parents $PACKER_FILES_DIR

RUN apt-get update --yes \
  && apt-get install --yes wget unzip

WORKDIR $PACKER_BIN_DIR
ENV PACKER_DOWNLOAD=packer_0.7.5_linux_amd64.zip
RUN wget https://dl.bintray.com/mitchellh/packer/$PACKER_DOWNLOAD \
  && unzip $PACKER_DOWNLOAD \
  && rm $PACKER_DOWNLOAD
ENV PATH=$PATH:$PACKER_BIN_DIR

# https://github.com/MSOpenTech/packer-azure#linux-dev-box
ENV HOME=/root
ENV GO_DOWNLOAD=go1.3.1.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV PATH=$PATH:$GOPATH/bin
RUN wget --directory-prefix $HOME/downloads https://storage.googleapis.com/golang/$GO_DOWNLOAD \
  && tar --directory /usr/local --extract --gzip --file $HOME/downloads/$GO_DOWNLOAD \
  && mkdir --parents $HOME/go \
  && apt-get install --yes git mercurial meld \
  && go get github.com/MSOpenTech/packer-azure/packer/builder/azure/driver_restapi \
  && go get github.com/hashicorp/yamux \
  && go get github.com/hashicorp/go-msgpack/codec \
  && go install -tags 'restapi' github.com/MSOpenTech/packer-azure/packer/plugin/packer-builder-azure \
  && go install github.com/MSOpenTech/packer-azure/packer/plugin/packer-provisioner-azure-custom-script-extension \
  && mv $GOPATH/bin/* $PACKER_BIN_DIR


WORKDIR $PACKER_FILES_DIR
CMD /bin/bash

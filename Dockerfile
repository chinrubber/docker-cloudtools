FROM golang:alpine

MAINTAINER "Chinrubber <admin@chinrubber.com>"

ENV TERRAFORM_VERSION=0.11.8
ENV GOOGLE_CLOUD_SDK_VERSION=212.0.0
ENV TERRAFORM_GSUITE_MODULE_VERSION=0.1.8

RUN mkdir /opt && \
    mkdir /opt/terraform && \
    apk --no-cache add \
	curl \
	bash \
	python && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz -C /opt && \
    rm google-cloud-sdk-${GOOGLE_CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    curl -O https://releases.hashicorp.com/terraform/0.11.8/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /opt/terraform && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mkdir $HOME/.terraform.d && \
    mkdir $HOME/.terraform.d/plugins && \
    curl -O -L https://github.com/DeviaVir/terraform-provider-gsuite/releases/download/v${TERRAFORM_GSUITE_MODULE_VERSION}/terraform-provider-gsuite_${TERRAFORM_GSUITE_MODULE_VERSION}_linux_amd64.tgz && \
    tar xzf terraform-provider-gsuite_${TERRAFORM_GSUITE_MODULE_VERSION}_linux_amd64.tgz && \
    rm terraform-provider-gsuite_${TERRAFORM_GSUITE_MODULE_VERSION}_linux_amd64.tgz && \
    mv terraform-provider-gsuite_v${TERRAFORM_GSUITE_MODULE_VERSION} $HOME/.terraform.d/plugins

ENV PATH=$PATH:/opt/google-cloud-sdk/bin:/opt/terraform

WORKDIR /opt

ENTRYPOINT ["/usr/bin/env"]

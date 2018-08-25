FROM golang:alpine

MAINTAINER "Chinrubber <admin@chinrubber.com>"

ENV TERRAFORM_VERSION=0.11.8
ENV GOOGLE_CLOUD_SDK_VERSION=213.0.0
ENV TERRAFORM_GSUITE_MODULE_VERSION=0.1.8
ENV SENTINEL_VERSION=0.3.1

RUN mkdir /opt && \
    mkdir /opt/terraform && \
    apk --no-cache add \
	git \
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
    mv terraform-provider-gsuite_v${TERRAFORM_GSUITE_MODULE_VERSION} $HOME/.terraform.d/plugins && \
    mkdir /opt/sentinel && \
    curl -O https://releases.hashicorp.com/sentinel/${SENTINEL_VERSION}/sentinel_${SENTINEL_VERSION}_linux_amd64.zip && \
    unzip sentinel_${SENTINEL_VERSION}_linux_amd64.zip -d /opt/sentinel && \
    rm sentinel_${SENTINEL_VERSION}_linux_amd64.zip && \
    go get github.com/palantir/tfjson

ENV PATH=$PATH:/opt/google-cloud-sdk/bin:/opt/terraform:/opt/sentinel

WORKDIR /opt

ENTRYPOINT ["/usr/bin/env"]

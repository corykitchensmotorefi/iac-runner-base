FROM ruby:2.7

ENV TERRAFORM_VERSION=0.15.5
ENV TERRASPACE_VERSION=0.6.10

# Install dependencies
RUN apt-get update && \ 
    apt-get install -y  \
            curl jq python3 bash \
            ca-certificates git openssl unzip wget

# Install Terraform
RUN cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

# Install Terraspace
RUN gem install terraspace -v ${TERRASPACE_VERSION}

COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

CMD ["which", "terraspace"]
ENTRYPOINT [ "./entrypoint.sh" ]
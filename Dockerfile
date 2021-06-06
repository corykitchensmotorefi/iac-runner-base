FROM ruby:2.7

ENV TERRAFORM_VERSION=0.15.5
ENV TERRASPACE_VERSION=0.6.10

# Install gcloud sdk/dependencies
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
        | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
        && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
        | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
        && apt-get update -y && apt-get install \
        google-cloud-sdk curl jq python3 bash ca-certificates git openssl unzip wget -y

# Install Terraform
RUN cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

# Install Terraspace
COPY Gemfile .

RUN gem install bundler
RUN bundle install

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

CMD ["which", "terraspace"]
ENTRYPOINT [ "./entrypoint.sh" ]
# This Dockerfile builds an Octopus worker image that does not rely on privileged execution
# to run Docker-in-Docker. All the required tools are installed directly in the image.

FROM ubuntu:22.04
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker

# Install some common utilities
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl unzip libicu-dev \
  && rm -rf /var/lib/apt/lists/*

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Install aws-iam-authenticator
RUN curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64 \
    && install -o root -g root -m 0755 aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install node.js
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install the serverless framework
RUN npm install -g serverless

# This is the start of the tentacle install
RUN curl -L \
    https://download.octopusdeploy.com/linux-tentacle/tentacle-6.2.206-linux_x64.tar.gz \
    --output tentacle-linux_x64.tar.gz
RUN mkdir /opt/octopus
RUN tar xvzf tentacle-linux_x64.tar.gz -C /opt/octopus
RUN echo '#!/bin/bash' > /opt/configure.sh
RUN echo '/opt/octopus/tentacle/Tentacle create-instance \
    --instance "Worker" \
    --config "/etc/octopus/Worker/tentacle-Worker.config"' \
    >> /opt/configure.sh
RUN echo '/opt/octopus/tentacle/Tentacle new-certificate \
    --instance "Worker" \
    --if-blank' \
    >> /opt/configure.sh
RUN echo '/opt/octopus/tentacle/Tentacle configure \
    --instance "Worker" \
    --app "/home/Octopus/Applications" \
    --noListen "True" --reset-trust' \
    >> /opt/configure.sh
RUN echo '/opt/octopus/tentacle/Tentacle register-worker \
    --instance "Worker" \
    --force --server "${ServerUrl}" \
    --name `hostname` \
    --comms-style "TentacleActive" \
    --server-comms-port "10943" \
    --apiKey "${ServerApiKey}" \
    --space "${Space}" \
    --workerpool "${TargetWorkerPool}"' \
    >> /opt/configure.sh
RUN echo '/opt/octopus/tentacle/Tentacle agent \
    --noninteractive \
    --instance "Worker"' >> /opt/configure.sh
RUN chmod +x /opt/configure.sh
ENTRYPOINT []
CMD ["/opt/configure.sh"]
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ARG RUNNER_VERSION="2.331.0"

# Install packages
RUN apt-get update && \
    apt-get install -y -qq --no-install-recommends \
      sudo curl wget jq build-essential libssl-dev libffi-dev \
      python3 python3-venv python3-dev python3-pip \
      unzip iptables iputils-ping dnsutils rsync yq \
      nodejs npm ca-certificates gnupg lsb-release

# Install Go
ARG GO_VERSION="1.24.2"
ENV PATH="/usr/local/go/bin:$PATH"
RUN wget -nv https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O go.tar.gz \
  && tar -xzf go.tar.gz -C /usr/local \
  && rm -f go.tar.gz \
  && go version

# GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
	&& apt-get install -y -qq gh

# Install the runner
RUN mkdir actions-runner && cd actions-runner && \
    curl -s -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
      -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Install runner dependencies
RUN apt-get install -y -qq libssl3t64 libicu74
RUN /actions-runner/bin/installdependencies.sh

# Create non-root user
RUN useradd -m -s /bin/bash github && \
    usermod -aG sudo github && \
    chown -R github:github /actions-runner && \
    echo "github ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/github && \
    chmod 0440 /etc/sudoers.d/github

WORKDIR /actions-runner
USER github

COPY --chown=github:github entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
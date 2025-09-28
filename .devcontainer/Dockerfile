# syntax=docker/dockerfile:1.6

# Ultimate Development Container: Ubuntu + Claude Code + AWS CLI + Pulumi + Python
# A comprehensive development environment for cloud infrastructure, AI development, and general coding

ARG VARIANT=3.11
ARG TARGETARCH=arm64

# ---- Stage 1: Base Ubuntu Development Environment -------------------------
FROM mcr.microsoft.com/devcontainers/python:${VARIANT}

ARG TARGETARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Update system and install core development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core system tools
    curl ca-certificates apt-transport-https gnupg lsb-release \
    wget git vim nano sudo \
    # Build essentials
    build-essential make \
    # Development utilities
    jq unzip zip bash-completion gnupg2 \
    # Security and authentication
    oathtool \
    # Node.js ecosystem (for Claude Code)
    nodejs npm \
    # Python development
    python3 python3-pip python3-dev \
    # Network and system utilities
    net-tools iputils-ping \
    # Text processing
    less tree \
 && update-ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# ---- Stage 2: Node.js Version Management and Claude Code ------------------
USER vscode
WORKDIR /home/vscode

# Install Node Version Manager (nvm) and latest Node.js LTS
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
 && export NVM_DIR="/usr/local/share/nvm" \
 && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
 && nvm install --lts && nvm use --lts && nvm alias default node

# Install Claude Code globally
RUN export NVM_DIR="/usr/local/share/nvm" \
 && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
 && npm install -g @anthropic-ai/claude-code

# Switch back to root for system-level installations
USER root

# ---- Stage 3: AWS CLI v2 Installation (Multi-Architecture) ---------------
RUN case "${TARGETARCH}" in \
        "amd64") AWS_ARCH="x86_64" ;; \
        "arm64") AWS_ARCH="aarch64" ;; \
        *) echo "Unsupported TARGETARCH: ${TARGETARCH}" && exit 1 ;; \
    esac \
 && echo "Installing AWS CLI for architecture: ${AWS_ARCH}" \
 && curl -fsSL --retry 5 --retry-connrefused --show-error \
      "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "/tmp/awscliv2.zip" \
 && unzip /tmp/awscliv2.zip -d /tmp \
 && /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli \
 && rm -rf /tmp/aws /tmp/awscliv2.zip \
 && aws --version

# ---- Stage 4: Pulumi Installation with Complete Python Support ------------

# Download and install Pulumi CLI
RUN case "${TARGETARCH}" in \
        "amd64") PULUMI_ARCH="x64" ;; \
        "arm64") PULUMI_ARCH="arm64" ;; \
        *) echo "Unsupported TARGETARCH: ${TARGETARCH}" && exit 1 ;; \
    esac \
 && PULUMI_VERSION="v3.196.0" \
 && echo "Installing Pulumi ${PULUMI_VERSION} for architecture: ${PULUMI_ARCH}" \
 && curl -fsSL "https://github.com/pulumi/pulumi/releases/download/${PULUMI_VERSION}/pulumi-${PULUMI_VERSION}-linux-${PULUMI_ARCH}.tar.gz" -o "/tmp/pulumi.tar.gz" \
 && cd /tmp \
 && tar -xzf pulumi.tar.gz \
 && cp pulumi/* /usr/local/bin/ \
 && chmod +x /usr/local/bin/pulumi* \
 && rm -rf pulumi.tar.gz pulumi/ \
 && pulumi version

# Install critical Python dependencies for Pulumi
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir \
    grpcio \
    protobuf \
    pulumi \
    # Additional useful Python packages
    requests \
    boto3 \
    pyyaml \
    click \
    rich

# Create Pulumi runtime environment
RUN mkdir -p /usr/local/lib/pulumi \
 && mkdir -p /root/.pulumi/plugins \
 && mkdir -p /root/.pulumi/bin

# Initialize Pulumi Python language plugin (skip for build)

# ---- Stage 5: AWS CLI Tab Completion and Shell Enhancements ---------------
RUN if command -v aws_completer >/dev/null 2>&1; then \
      echo "complete -C '$(command -v aws_completer)' aws" >> /etc/bash.bashrc; \
    fi

# Add helpful aliases and environment setup
RUN echo 'alias ll="ls -la"' >> /etc/bash.bashrc \
 && echo 'alias la="ls -A"' >> /etc/bash.bashrc \
 && echo 'alias l="ls -CF"' >> /etc/bash.bashrc \
 && echo 'alias ..="cd .."' >> /etc/bash.bashrc \
 && echo 'alias ...="cd ../.."' >> /etc/bash.bashrc \
 && echo 'export EDITOR=vim' >> /etc/bash.bashrc \
 && echo 'export PULUMI_SKIP_UPDATE_CHECK=true' >> /etc/bash.bashrc

# ---- Stage 6: User Environment Setup ---------------------------------------
USER vscode

# Set up user-specific Pulumi directories
RUN mkdir -p ~/.pulumi/plugins \
 && mkdir -p ~/.pulumi/bin

# Add Node.js and npm paths to user environment
RUN echo 'export PATH="$HOME/.nvm/versions/node/$(nvm current)/bin:$PATH"' >> ~/.bashrc \
 && echo 'source ~/.nvm/nvm.sh' >> ~/.bashrc \
 && echo 'export PULUMI_SKIP_UPDATE_CHECK=true' >> ~/.bashrc

# ---- Stage 7: Development Environment Preparation -------------------------
WORKDIR /workspaces

# Copy requirements.txt if it exists (for layer caching)
COPY requirements.txt* /tmp/
RUN if [ -f /tmp/requirements.txt ]; then \
      pip install --no-cache-dir -r /tmp/requirements.txt; \
    fi

# Final verification
RUN export NVM_DIR="/usr/local/share/nvm" \
 && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
 && node --version \
 && npm --version \
 && claude --version || echo 'Claude Code will be available after container starts' \
 && aws --version \
 && pulumi version \
 && python --version

# Set default working directory
WORKDIR /workspaces/ultimate-dev-container

# Default command
CMD ["/bin/bash"]
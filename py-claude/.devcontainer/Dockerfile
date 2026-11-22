FROM python:3.12-slim-bookworm

# Install development dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash curl ca-certificates git sudo openssh-client \
    build-essential procps \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x \
    -o /tmp/nodesource_setup.sh \
    && bash /tmp/nodesource_setup.sh \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* /tmp/nodesource_setup.sh

# Install OpenAI Codex CLI
RUN npm install -g @openai/codex

# Create non-root development user
RUN useradd -m -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" \
       > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer

# Prepare private Codex directory
RUN mkdir -p /home/developer/.codex \
    && chown -R developer:developer /home/developer/.codex \
    && chmod 700 /home/developer/.codex

COPY --chmod=0644 init-codex-auth.sh /usr/local/bin/init-codex-auth.sh

USER developer
WORKDIR /home/developer


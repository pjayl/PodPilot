
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

# Create non-root development user
RUN useradd -m -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD:ALL" \
       > /etc/sudoers.d/developer \
    && chmod 0440 /etc/sudoers.d/developer

# Prepare private Claude directory
RUN mkdir -p /home/developer/.claude \
    && chown -R developer:developer /home/developer/.claude \
    && chmod 700 /home/developer/.claude

# Load the OAuth token in every shell, including non-interactive SSH commands.
# The block goes before Debian's interactive-only guard in ~/.bashrc.
RUN { \
      echo 'export PATH="$HOME/.local/bin:$PATH"'; \
      echo 'if [ -r "$HOME/.claude/oauth-token" ]; then'; \
      echo '  CLAUDE_CODE_OAUTH_TOKEN="$(cat "$HOME/.claude/oauth-token")"'; \
      echo '  export CLAUDE_CODE_OAUTH_TOKEN'; \
      echo 'fi'; \
      cat /home/developer/.bashrc; \
    } > /tmp/bashrc \
    && install -o developer -g developer -m 0644 /tmp/bashrc /home/developer/.bashrc \
    && rm /tmp/bashrc

COPY --chmod=0644 init-claude-auth.sh /usr/local/bin/init-claude-auth.sh

USER developer
WORKDIR /home/developer

# Install Claude Code (native build, user-owned so it can update itself)
RUN curl -fsSL https://claude.ai/install.sh | bash

ENV PATH="/home/developer/.local/bin:${PATH}"

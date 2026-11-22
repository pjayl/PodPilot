# DevPod

See [README.md](README.md) for usage and requirements.

- `devpod-up` selects a profile from its first argument and mounts the project directory from its second argument. The workspace ID depends on the profile and the project's absolute path.
- `py-codex/.devcontainer/` contains the Python and Codex profile. The startup hook runs the authentication script bundled in the image, so it can run with projects outside this repository.
- `py-claude/.devcontainer/` is the Claude Code counterpart of `py-codex`. Its startup hook copies the host's `~/.claude/devpod-oauth-token` into the container, and `~/.bashrc` exports it as `CLAUDE_CODE_OAUTH_TOKEN`.
- After a successful start, the wrapper makes sure the container has a matching Herdr version and registers its SSH address if needed.

# DevPod

Start a local Python and Codex environment for any project directory.

## Requirements

The host needs Python 3, DevPod with the local `docker` provider configured, an SSH client, and Herdr. The `py-codex` profile uses the host's Codex authentication file at `~/.codex/auth.json`.

## Usage

From the repository root, run:

```sh
./devpod-up py-codex ~/code/my-project
```

The first argument selects the profile. The second is the project directory. The `py-codex` profile mounts the project at `/workspace` and provides Python 3.12, Node.js 22, and Codex CLI. DevPod prints the container's SSH address. The wrapper skips automatic IDE launch and registers the container with Herdr if its SSH address is missing from the machine list.

The `py-claude` profile is the Claude Code counterpart: the same Python 3.12 and Node.js 22 base with Claude Code instead of Codex CLI. On macOS, Claude Code keeps its login in the Keychain, so the container cannot reuse it directly. Generate a long-lived token once on the host and save it:

```sh
claude setup-token
# paste the printed token into the file:
(umask 077; pbpaste > ~/.claude/devpod-oauth-token)
./devpod-up py-claude ~/code/my-project
```

On start, the container copies the token to `~/.claude/oauth-token` (mode 600), and every shell exports it as `CLAUDE_CODE_OAUTH_TOKEN`.

To add a profile, create a directory with its own `.devcontainer/devcontainer.json` and pass that directory's name as the first argument.

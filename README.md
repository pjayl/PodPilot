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

To add a profile, create a directory with its own `.devcontainer/devcontainer.json` and pass that directory's name as the first argument.

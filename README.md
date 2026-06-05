# Dotfiles

Personal shell, editor, and workflow configuration for macOS/Linux development.

## What is in this repo

- Shell config for Bash and Zsh: `bashrc`, `zshrc`, `bash_aliases`, `bash_functions`, `bash_profile`, `zprofile`
- Vim/Neovim config: `vimrc` and `vim/`
- Homebrew package list: `Brewfile`
- Cluster environment tooling: `cluster-env/`
- Wrapper scripts: `wrapper_scripts/`
- Symlink bootstrap scripts: `symlink/`

## Repository layout

```text
.
|- bash_aliases
|- bash_functions
|- bashrc
|- zshrc
|- vimrc
|- Brewfile
|- cluster-env/
|- symlink/
|- wrapper_scripts/
```

## Prerequisites

- macOS with Homebrew installed
- Git
- Go
- kubectl

Optional but commonly used with this repo:

- AWS CLI / aws-vault
- Terraform
- gh CLI

## Quick start

1. Clone this repository to the expected path:

```bash
mkdir -p "$HOME/repo/jackstockley89"
cd "$HOME/repo/jackstockley89"
git clone git@github.com:jackstockley89/dotfiles.git
cd dotfiles
```

2. Install packages from the Brewfile:

```bash
brew bundle --file ./Brewfile
```

3. Create dotfile symlinks in your home directory:

```bash
cd symlink/shell
bash ./symlink.bash
```

4. Reload shell config:

```bash
source ~/.zshrc
# or
source ~/.bashrc
```

## Symlink management

The script `symlink/shell/symlink.bash` creates or repairs symlinks in `$HOME` using the list in `symlink/shell/symlist.txt`.

Notes:

- The script expects this repository at `$HOME/repo/jackstockley89/dotfiles`.
- Existing files/directories at target locations are replaced.

## Cluster environment tooling

The cluster selector lives in `cluster-env/` and supports two modes:

- Full cluster workflow (kube + terraform + terminal title)
- AWS env-only setup

Run it from `cluster-env/`:

```bash
cd cluster-env
go run select-cluster-config.go -p cp-dev
```

Valid profiles:

- `cp-dev`
- `cp-preprod`
- `cp-nonlive`
- `cp-live`
- `dev-clusters`

AWS env-only mode:

```bash
go run select-cluster-config.go -p cp-dev -aws true
```

For `-p dev-clusters -aws true`, AWS profile defaults to `cp-dev`.

## Wrapper scripts

Entry point:

```bash
bash wrapper_scripts/overview.bash
```

Other scripts are in `wrapper_scripts/shell/` for tasks such as:

- rotating access keys
- searching Kubernetes secrets
- state lock cleanup
- Brewfile updates

## Shell behavior

- `zshrc` and `bashrc` source `~/.bash_aliases` and `~/.bash_functions`.
- `kubectl` completions are enabled for both Bash and Zsh.
- Prompt behavior changes based on whether `KUBECONFIG` is set.

## Vim setup

`vimrc` and `vim/` contain plugin and editor configuration used by this setup.

## Troubleshooting

### Symlink script says links are missing/incorrect

- Ensure repo path is exactly `$HOME/repo/jackstockley89/dotfiles`.
- Re-run `bash symlink/shell/symlink.bash`.

### Cluster selector exits with profile error

- Ensure `-p` is one of the supported profile values.
- Example: `go run select-cluster-config.go -p cp-dev -aws true`

### Shell changes not applied

- Reload your shell: `source ~/.zshrc` or `source ~/.bashrc`
- Open a new terminal session.

# dotfiles

Bootstrap dev environments in a single command!

This dotfiles repository is currently aimed for Ubuntu on WSL, Ubuntu Server, and Ubuntu Desktop, or MacOS

It's also suitable for use in GitHub Codespaces, Gitpod, VS Code Remote - Containers.

Managed with [https://chezmoi.io/](https://chezmoi.io/), a great dotfiles manager.

## Getting started

Check out the [Quick Start](https://www.chezmoi.io/quick-start/) page.

### Install chezmoi and the dotfiles on any new machine

With a single command:

```sh
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply ngshiheng
```

### Update

On any machine, you can pull and apply the latest changes from your repo with:

```sh
chezmoi update -v
```
# dotfiles

Bootstrap dev environments in a single command!

This dotfiles repository is currently aimed for Ubuntu on WSL, Ubuntu Server, and Ubuntu Desktop, or MacOS

It's also suitable for use in GitHub Codespaces, Gitpod, VS Code Remote - Containers.

Managed with [mise](https://mise.jdx.dev/), a great dotfiles manager.

## Getting started

Check out the [Quick Start](https://mise.jdx.dev/walkthrough.html) page.

### Install mise and the dotfiles and recommended tools on any new machine

With a single command:

```sh
./home/bin/bootstrap.sh
```

- `[bootstrap.repos]` Execution:
  mise clones repository from GitHub into `~/dotfiles` (which resolves to /home/user/dotfiles).

- `[dotfiles]` Execution:
  mise looks inside $settings.dotfiles.root (/home/user/dotfiles).
  Because of config "~~/_" = "home/_", it finds every file and directory directly inside /home/user/dotfiles/home/ and creates symbolic links (symlinks) to them in /home/user/.
  Because of config "~~/.config/_" = "home/.config/_", it finds every file and directory directly inside /home/user/dotfiles/home/.config/ and creates symbolic links to them in /home/user/.config/.

- installs missing [tools].

### Update

On any machine, you can pull and apply the latest changes from your repo with:

```sh
mise bootstrap -f -y
```

### Add a package

```sh
mise bootstrap packages use apk:zlib-dev apt:libssl-dev
```

This writes `[bootstrap.packages]` and installs what is missing.

### Capture an edited dotfile

```sh
$EDITOR ~/.zshrc
mise bootstrap dotfiles add ~/.zshrc
```

`mise bootstrap dotfiles add` stores the live file under `dotfiles.root` and writes an explicit `[dotfiles]` entry with mode.

### Edit a managed dotfile

```sh
mise bootstrap dotfiles edit ~/.zshrc
mise bootstrap dotfiles apply ~/.zshrc
```

`mise bootstrap dotfiles edit` opens the managed source, so it works with the default symlink mode.
`mise bootstrap dotfiles apply` applies the changes to the live file.

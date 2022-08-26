#!/bin/sh
# -*-mode:sh-*- vim:ft=shell-script

# ~/install.sh
# =============================================================================
# Idempotent manual setup script to install or update shell dependencies.

set -e

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

error() {
    printf -- "%sError: $*%s\n" >&2 "$RED" "$RESET"
}

setup_color() {
    # Only use colors if connected to a terminal
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        # YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        # YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

setup_dependencies() {
    printf -- "\n%sSetting up dependencies:%s\n\n" "$BOLD" "$RESET"

    # Install Homebrew
    # https://brew.sh/
    if command -v brew > /dev/null; then
        printf -- "%s$(date -u):\t Updating Homebrew...%s\n" "$BLUE" "$RESET"
        brew update
    else
        printf -- "%s$(date -u):\t Installing Homebrew...%s\n" "$BLUE" "$RESET"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install Homebrew packages
    if command -v brew > /dev/null; then
        printf -- "%sInstalling/updating apps using Homebrew...%s\n" "$BLUE" "$RESET"
        brew bundle --global
        brew bundle --global --force cleanup 
    fi
}

# shellcheck source=/dev/null
setup_devtools() {
    printf -- "\n%sSetting up development tools:%s\n\n" "$BOLD" "$RESET"

    command_exists git || {
        error "git is not installed"
        exit 1
    }

    # Linking Oh My Tmux
    [ -f "$HOME"/.tmux/.tmux.conf ] && ln -s -f -v .tmux/.tmux.conf "$HOME"
    

    # Install ASDF Versionn Manager
    # https://asdf-vm.com/
    # if ! command -v brew > /dev/null; then
    #     printf -- "%sInstalling/updating ASDF Extendable Version Manager...%s\n" "$BLUE" "$RESET"
    #     export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}" && (
    #         ASDF_NEW=false
    #         if [ ! -d "$ASDF_DIR" ]; then
    #             git clone https://github.com/asdf-vm/asdf.git "$NVM_DIR"
    #             ASDF_NEW=true
    #         fi
    #         cd "$ASDF_DIR"
    #         if [ $ASDF_NEW ]; then
    #             git checkout "$(git describe --abbrev=0 --tags)"
    #         else
    #             asdf update
    #         fi
    #     ) && \. "$ASDF_DIR/nvm.sh" && ([ -z "$BASH_VERSION" ] || \. "$ASDF_DIR/completions/asdf.bash")
    # fi

    printf -- "%sInstalling ASDF plugins...%s\n" "$BLUE" "$RESET"
    asdf plugin add golang && status=$? || status=$?
    asdf plugin add nodejs && status=$? || status=$?
    asdf plugin add php && status=$? || status=$?
    asdf plugin add python && status=$? || status=$?
    asdf plugin add ruby && status=$? || status=$?

    printf -- "%sUpdating ASDF plugins...%s\n" "$BLUE" "$RESET"
    asdf plugin update --all

    # `asdf plugin-add` returns exit code 2 when plugin already installed, but it's not an error.
    [[ $status -ne 0 && $status -ne 2 ]] && exit $status

    # printf -- "%sImporting PGP keyrings for ASDF plugins...%s\n" "$BLUE" "$RESET"
    # "$HOME"/.asdf/plugins/nodejs/bin/import-release-team-keyring

    printf -- "%sInstalling golang...%s\n" "$BLUE" "$RESET"
    asdf install golang latest

    printf -- "%sInstalling nodejs...%s\n" "$BLUE" "$RESET"
    asdf install nodejs latest

}

main() {
    setup_color
    printf -- "\n%sDotfiles setup script%s\n" "$BOLD" "$RESET"

    command_exists chezmoi || {
        error "chezmoi is not installed"
        exit 1
    }

    setup_dependencies
    setup_devtools

    printf -- "\n%sDone.%s\n\n" "$GREEN" "$RESET"

}

main "$@"
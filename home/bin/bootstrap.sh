#!/usr/bin/env bash
set -e

echo "🚀 Starting machine bootstrap..."

# 1. Install system essentials based on OS
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
    echo "Detected macOS..."
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Install build essential tools if needed
    brew install gcc git curl zsh
elif [ "$OS" = "Linux" ]; then
    echo "Detected Linux..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y build-essential curl git zsh
    elif command -v dnf &>/dev/null; then
        sudo dnf groupinstall -y "Development Tools" && sudo dnf install -y curl git zsh
    elif command -v pacman &>/dev/null; then
        sudo pacman -Syu --noconfirm base-devel curl git zsh
    fi
fi

# 2. Install mise
if ! command -v mise &>/dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
    export PATH="$HOME/.local/share/mise/bin:$HOME/.local/bin:$PATH"
fi

# 3. Native mise declarative bootstrap execution
# This clones repos from [bootstrap.repos], applies [dotfiles], and installs [tools]
mise bootstrap -f -y

# 4. Optional: Set Zsh as default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

# 5. Refresh font cache for Linux
mise run install-fonts-linux

echo "✅ Setup complete! Restart your terminal."

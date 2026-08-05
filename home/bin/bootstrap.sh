#!/usr/bin/env bash
set -e

# Always switch context to $HOME
cd "$HOME"

# Detect Operating System
OS="$(uname -s)"

echo "🚀 Starting machine bootstrap in $PWD..."

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

MISE_BIN="$HOME/.local/bin/mise"
MISE_ALT_BIN="$HOME/.local/share/mise/bin/mise"

if [ -f "$MISE_BIN" ]; then
    MISE_EXEC="$MISE_BIN"
elif [ -f "$MISE_ALT_BIN" ]; then
    MISE_EXEC="$MISE_ALT_BIN"
elif command -v mise &>/dev/null; then
    MISE_EXEC="mise"
else
    echo "Installing mise..."
    curl https://mise.run | sh
    MISE_EXEC="$HOME/.local/bin/mise"
fi


# 3. Pre-seed global mise config from GitHub so mise knows what to bootstrap
case "$OS" in
    Linux*)  CONFIG_FILE="config.linux.toml" ;;
    Darwin*) CONFIG_FILE="config.macos.toml" ;;
    *)
        echo "Error: Unsupported OS '$OS'" >&2
        exit 1
        ;;
esac

echo "Downloading global mise configuration ($CONFIG_FILE)..."
mkdir -p "$HOME/.config/mise"
curl -fsSL -H "Cache-Control: no-cache" \
    https://raw.githubusercontent.com/phaneendra/dotfiles/master/home/.config/mise/$CONFIG_FILE \
    -o "$HOME/.config/mise/config.toml"

# Tell Mise to load the platform file via environment variable (or ~/.miserc.toml)
if [[ "$(uname -s)" == "Darwin" ]]; then
    export MISE_ENV="macos"
else
    export MISE_ENV="linux"
fi

# Clean up dirty local state in ~/dotfiles if it exists
if [ -d "$HOME/dotfiles/.git" ]; then
    echo "🧹 Cleaning untracked changes in ~/dotfiles..."
    git -C "$HOME/dotfiles" reset --hard HEAD
    git -C "$HOME/dotfiles" clean -fd
fi

# Force mise to purge stale cached configs from memory
echo "Clearing mise config cache..."
"$MISE_EXEC" cache clear

# 4. Native mise declarative bootstrap execution
# This clones repos from [bootstrap.repos], applies [dotfiles], and installs [tools]
"$MISE_EXEC" bootstrap -y --force-dotfiles

# 5. Optional: Set Zsh as default shell if not already set
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

# 6. Refresh font cache for Linux
if [ "$OS" = "Linux" ]; then
    echo "==> Running Linux font setup..."
    "$MISE_EXEC" run install-fonts-linux
elif [ "$OS" = "Darwin" ]; then
    echo "==> Skipping Linux font setup on macOS."
fi

echo "✅ Setup complete! Restart your terminal."

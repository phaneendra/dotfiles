# =============================================================================
# Executed by Z shell for interactive shells.
#
# See http://zsh.sourceforge.net/

# shellcheck shell=bash
# shellcheck source=/dev/null
# shellcheck disable=SC2034

# Hide default user from local prompt.
export DEFAULT_USER="${USER}"

# Disable autosuggestion for large buffers.
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"

# Enable aynchronous mode.
export ZSH_AUTOSUGGEST_USE_ASYNC=true

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker                  # Aliases for [Docker](https://www.docker.com/)
  docker-compose          # Aliases for [Docker-Compose](https://docs.docker.com/compose/)
  dotenv                  # Load project ENV variables from folder `.env` files
  rsync                   # Aliases for `rsync` command
  # zsh-autocomplete        # Autocompletion for Zsh (https://github.com/zsh-users/zsh-autocomplete)
  fzf-tab                 # Autocompletion for Zsh using fzf
  zsh-autosuggestions     # Command suggestions based on history and completions (https://github.com/zsh-users/zsh-autosuggestions)
  zsh-syntax-highlighting # Fish shell like syntax highlighting (https://github.com/zsh-users/zsh-syntax-highlighting)
)

if [[ "$OSTYPE" =~ ^darwin ]]; then
    plugins+=(
        osx                 # Utilities for macOS
    )
fi


# Load Oh My Zsh
. "$ZSH"/oh-my-zsh.sh

# User configuration

if [ -d /usr/local/man ]; then
    export MANPATH="/usr/local/man:$MANPATH"
fi

# ---------- Pager ----------
if command -v bat >/dev/null 2>&1; then
  export PAGER="bat"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
  export PAGER="batcat"
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

# You may need to manually set your language environment

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS          # Don't record contiguous duplicates
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from each command
setopt INC_APPEND_HISTORY        # Write to history file immediately, not on exit
setopt SHARE_HISTORY             # Share history across sessions safely

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Set preferred editor for local and remote sessions.
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# elif command -v mvim > /dev/null; then
#     export EDITOR='mvim';
# else
#     export EDITOR='vim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Command-line shell completions
# -----------------------------------------------------------------------------

# Provide Homebrew completions (if installed).
# See https://docs.brew.sh/Shell-Completion
if type brew &> /dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Varia
# -----------------------------------------------------------------------------

# Point ripgrep to its configuration file.
# See https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md


# Includes
# -----------------------------------------------------------------------------

# Load cross-compatible Bash functions declarations from separate file.
if [ -f "$HOME"/.bash_functions ]; then
    \. "$HOME"/.bash_functions
fi

# Load cross-compatible Bash alias definitions from separate file.
if [ -f "$HOME"/.bash_aliases ]; then
    \. "$HOME"/.bash_aliases
fi

# Load cross-compatible Bash custom code from separate file.
if [ -f "$HOME"/.bash_extras ]; then
    \. "$HOME"/.bash_extras
fi

# Load path info from .profile
if [ -f "$HOME"/.profile ]; then
    \. "$HOME"/.profile
fi


# Activate mise inside Zsh
eval "$(~/.local/bin/mise activate zsh)"

# FZF
# -----------------------------------------------------------------------------

show_file_or_dir_preview='if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- fzf-tab Configurations ---
# Enable rich previews with bat and eza/ls during tab completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath || ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [ -d $realpath ]; then eza -1 --color=always $realpath; else bat --color=always --line-range :500 $realpath 2>/dev/null; fi'


# Zoxide (better cd)
# -----------------------------------------------------------------------------
eval "$(zoxide init zsh)"

# Run fastfetch for interactive terminals
if [[ $- == *i* ]] && command -v fastfetch &>/dev/null; then
  fastfetch
fi

# Starship (prompt)
# -----------------------------------------------------------------------------
# Load Starship prompt this should be the last line
eval "$(starship init zsh)"

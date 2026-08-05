# ~/.zshenv — environment for all zsh shells (interactive and non-interactive)
# Keep this file minimal: only persistent environment variables and lightweight inits.

# Locale
export LANG=en_US.UTF-8

# Bat theme
export BAT_THEME=tokyonight_night

# Ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fzf theme colors (used by FZF_DEFAULT_OPTS)
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

# Preview helper used by fzf previews
show_file_or_dir_preview='if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'

# fzf defaults (use only portable/env-safe values here)
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Source ~/.profile once to import PATH and other login-time exports (safe: no output expected)
# Keep PATH/tool management centralized in ~/.profile. Guard to avoid double sourcing.
if [ -z "${PROFILE_LOADED-}" ]; then
  if [ -f "$HOME/.profile" ]; then
    # shellcheck disable=SC1090
    . "$HOME/.profile"
  fi
  export PROFILE_LOADED=1
fi

# MISE environment
if [[ "$(uname -s)" == "Darwin" ]]; then
  export MISE_ENV="macos"
else
  export MISE_ENV="linux"
fi

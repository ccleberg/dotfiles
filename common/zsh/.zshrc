# ==============================================================================
# 1. OS-SPECIFIC CONFIGURATION
# ==============================================================================

# Use uname to detect the OS and set the correct Homebrew path
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS (Apple Silicon)
  BREW_PREFIX="/opt/homebrew"
elif [[ "$(uname)" == "Linux" ]]; then
  # Linux (Linuxbrew)
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# ==============================================================================
# 2. PRE-INITIALIZATION (Instant Prompt)
# ==============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 3. ENVIRONMENT VARIABLES & PATH
# ==============================================================================

export PATH="$HOME/.local/xonsh-env/xbin:$PATH"
export PATH="$BREW_PREFIX/bin:$PATH"
export GPG_TTY=$(tty)

# borgbackup
if [[ "$(uname)" == "Linux" ]]; then
  export BORG_CACHE_DIR="/tank/borg-cache"
  mkdir -p /tank/borg-cache
fi

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
NVM_SH_PATH="$BREW_PREFIX/opt/nvm/nvm.sh"
if [[ -s "$NVM_SH_PATH" ]]; then
  source "$NVM_SH_PATH"
fi

NVM_BASH_COMPLETION_PATH="$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
if [[ -s "$NVM_BASH_COMPLETION_PATH" ]]; then
  source "$NVM_BASH_COMPLETION_PATH"
fi

# History Settings
HISTFILE=~/.histfile
HISTSIZE=30000
SAVEHIST=30000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# ==============================================================================
# 4. COMPLETION & UI SETTINGS
# ==============================================================================

bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit

# p10k
P10K_THEME_PATH="$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
if [[ -f "$P10K_THEME_PATH" ]]; then
  source "$P10K_THEME_PATH"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================
# 5. ALIASES
# ==============================================================================

alias l='eza -lah --icons --git --group-directories-first --header'
alias cd="z"
alias cat="bat --paging=never --theme=Coldark-Cold"
alias mkdir="mkdir -p"
alias grep="rg"
alias find="fd"
alias emacs="emacs -nw"
alias xclean="fd -H '.DS_Store' -t f -x rm"

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gma='git checkout main'

# ==============================================================================
# 6. PLUGINS (Must be loaded after aliases for best results)
# ==============================================================================

# Zsh Autosuggestions
ZSH_AUTOSUGGESTIONS_PATH="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "$ZSH_AUTOSUGGESTIONS_PATH" ]]; then
  source "$ZSH_AUTOSUGGESTIONS_PATH"
fi

# Syntax Highlighting
ZSH_SYNTAX_HIGHLIGHTING_PATH="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$ZSH_SYNTAX_HIGHLIGHTING_PATH" ]]; then
  source "$ZSH_SYNTAX_HIGHLIGHTING_PATH"
fi

# ==============================================================================
# 7. SYNTAX HIGHLIGHTING CUSTOMIZATION
# ==============================================================================

# Must be defined AFTER the plugin is sourced
# Colors available: black, red, green, yellow, blue, magenta, cyan, white
# Styles: bold, underline

ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'

# zoxide
eval "$(zoxide init zsh)"


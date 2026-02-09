# ==============================================================================
# 1. PRE-INITIALIZATION (Instant Prompt)
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. ENVIRONMENT VARIABLES & PATH
# ==============================================================================
export PATH="/Users/cmc/.local/xonsh-env/xbin:$PATH"
export GPG_TTY=$(tty)

# borgbackup
export BORG_CACHE_DIR="/tank/borg-cache"
mkdir -p /tank/borg-cache

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# History Settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# ==============================================================================
# 3. COMPLETION & UI SETTINGS
# ==============================================================================
bindkey -e
zstyle :compinstall filename '/Users/cmc/.zshrc'
autoload -Uz compinit && compinit

# Load Theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================
# 4. ALIASES
# ==============================================================================
alias l="ls -lha"
alias emacs="emacs -nw"
alias xclean="find . -name '.DS_Store' -type f -delete"

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
# 5. PLUGINS (Must be loaded after aliases for best results)
# ==============================================================================
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting MUST be the last thing sourced
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==============================================================================
# 6. SYNTAX HIGHLIGHTING CUSTOMIZATION
# ==============================================================================
# Must be defined AFTER the plugin is sourced
# Colors available: black, red, green, yellow, blue, magenta, cyan, white
# Styles: bold, underline

# Highlight aliases in Cyan
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'

# Highlight standard commands in Green
ZSH_HIGHLIGHT_STYLES[command]='fg=green'

# Highlight built-ins (like cd, echo) in Magenta
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'

# Highlight valid paths in White with an underline
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'

# Highlight errors (typos) in Red
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'

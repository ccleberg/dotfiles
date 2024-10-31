export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$PATH:/Library/TeX/texbin"
export PATH="$PATH:/Users/cmc/.local/bin"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nano

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bureau"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# bun completions
[ -s "/Users/cmc/.bun/_bun" ] && source "/Users/cmc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias ls="eza"
alias l="eza -lha"
alias emacs="emacs -nw"
alias cat="bat"
alias tsm="transmission-remote"
alias pip3="pipx"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/cmc/.cache/lm-studio/bin"

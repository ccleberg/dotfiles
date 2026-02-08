echo 'export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH' >> ~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export GPG_TTY=$(tty)

alias l="ls -lha"
alias emacs="emacs -nw"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/cmc/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH
export PATH=/Users/cmc/.local/xonsh-env/xbin:$PATH

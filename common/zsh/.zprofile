# ==============================================================================
# HOMEBREW INITIALIZATION (macOS & Linux)
# ==============================================================================

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS (Apple Silicon)
  BREW_PATH="/opt/homebrew/bin/brew"
  # Display Message of the Day (MOTD)
  ./motd.sh
elif [[ "$(uname)" == "Linux" ]]; then
  # Linux (Linuxbrew)
  BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
fi

# Only run shellenv if the brew binary actually exists at that path
if [[ -f "$BREW_PATH" ]]; then
  eval "$($BREW_PATH shellenv)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

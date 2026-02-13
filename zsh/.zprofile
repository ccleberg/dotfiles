# ==============================================================================
# HOMEBREW INITIALIZATION (macOS & Linux)
# ==============================================================================

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS (Apple Silicon)
  BREW_PATH="/opt/homebrew/bin/brew"
elif [[ "$(uname)" == "Linux" ]]; then
  # Linux (Linuxbrew)
  BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
fi

# Only run shellenv if the brew binary actually exists at that path
if [[ -f "$BREW_PATH" ]]; then
  eval "$($BREW_PATH shellenv)"
fi

#!/usr/bin/env bash

# Get the directory where this script lives
MACOS_DIR=$(dirname "$(realpath "$0")")

echo "🍺 Syncing Homebrew with Brewfile..."

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Use bundle to install everything in the Brewfile
# --cleanup would remove anything NOT in the Brewfile (use with caution!)
brew bundle --file="$MACOS_DIR/Brewfile"

# Restart services to ensure they pick up any stowed config changes
echo "♻️  Restarting services..."
brew services restart koekeishiya/formulae/yabai
brew services restart koekeishiya/formulae/skhd

echo "✅ macOS environment synced."

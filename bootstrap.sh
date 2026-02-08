#!/usr/bin/env bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Starting dotfiles bootstrap..."

# 1. Check if GNU Stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed.${NC}"
    echo "Please install it via your package manager (brew install stow / apt install stow)."
    exit 1
fi

# 2. Get the directory where this script is located
DOTFILES_DIR=$(dirname "$(realpath "$0")")
cd "$DOTFILES_DIR"

# 3. Define packages based on your folder structure
PACKAGES=(doom git ispell skhd yabai zsh)

echo "Symlinking packages..."

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo -e "Stowing: ${GREEN}$pkg${NC}"
        stow -R "$pkg"
    else
        echo -e "${RED}Warning: Package directory '$pkg' not found. Skipping.${NC}"
    fi
done

echo -e "${GREEN}Done! Your dotfiles are now stowed.${NC}"

#!/usr/bin/env bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE} Starting dotfiles bootstrap...${NC}"

# 1. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${GREEN}✓ Homebrew is already installed${NC}"
fi

# 2. Install Dependencies
echo "Checking dependencies..."
DEPENDENCIES=(
    stow
    zsh-autosuggestions
    zsh-syntax-highlighting
    romkatv/powerlevel10k/powerlevel10k
)

for dep in "${DEPENDENCIES[@]}"; do
    if brew list "$dep" &>/dev/null || brew list --cask "$dep" &>/dev/null; then
        echo -e "${GREEN}✓ $dep is already installed${NC}"
    else
        echo "Installing $dep..."
        brew install "$dep"
    fi
done

# 3. Get the directory where this script is located
DOTFILES_DIR=$(dirname "$(realpath "$0")")
cd "$DOTFILES_DIR"

# 4. Define packages based on your folder structure
PACKAGES=(doom git ispell skhd yabai zsh)

echo -e "${BLUE} Symlinking packages with GNU Stow...${NC}"

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo -e "Stowing: ${GREEN}$pkg${NC}"
        # -R (restow) is safer as it prunes dead links and updates new ones
        stow -R "$pkg"
    else
        echo -e "${RED}Warning: Package directory '$pkg' not found. Skipping.${NC}"
    fi
done

echo -e "${GREEN} Done! Your environment is ready.${NC}"
echo "Note: You may need to restart your terminal or run 'source ~/.zshrc'"

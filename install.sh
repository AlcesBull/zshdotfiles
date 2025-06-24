#!/bin/bash

# Zsh Dotfiles Installation Script
# This script will install your zsh configuration locally

set -e

echo "🚀 Setting up zsh dotfiles..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup existing .zshrc if it exists
if [[ -f "$HOME/.zshrc" ]]; then
    echo "📦 Backing up existing .zshrc to .zshrc.backup"
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config/zsh"

# Copy the zsh configuration files
echo "📁 Installing zsh configuration..."
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/.config/zsh/base.zsh" "$HOME/.config/zsh/"

# Make sure the files are readable
chmod 644 "$HOME/.zshrc"
chmod 644 "$HOME/.config/zsh/base.zsh"

echo "✅ Zsh configuration installed successfully!"
echo ""
echo "🎯 Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. (Optional) Install terminal enhancement tools by running: setup-terminal"
echo ""
echo "💡 The setup-terminal command will install:"
echo "   - bat (better cat)"
echo "   - jq (JSON processor)"
echo "   - git-delta (better git diffs)"
echo "   - glow (markdown renderer)"
echo "   - ripgrep (faster grep)"
echo "   - zsh-autosuggestions"
echo "   - zsh-syntax-highlighting"
echo ""
echo "🔧 Your new zsh configuration includes:"
echo "   - Git-aware prompt with status indicators"
echo "   - Useful aliases and functions"
echo "   - Better history management"
echo "   - Colorized output for various commands" 
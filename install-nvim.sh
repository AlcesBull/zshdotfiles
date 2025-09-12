#!/bin/bash

# Neovim Configuration Installation Script
# This script will install your Neovim configuration locally

set -e

echo "🚀 Setting up Neovim configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup existing nvim config if it exists
if [[ -d "$HOME/.config/nvim" ]]; then
    echo "📦 Backing up existing nvim config to nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
fi

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Copy the nvim configuration files
echo "📁 Installing Neovim configuration..."
cp -r "$SCRIPT_DIR/nvim-config" "$HOME/.config/nvim"

# Make sure the files are readable
find "$HOME/.config/nvim" -type f -name "*.lua" -exec chmod 644 {} \;

echo "✅ Neovim configuration installed successfully!"
echo ""
echo "🎯 Next steps:"
echo "1. Open Neovim: nvim"
echo "2. Wait for Lazy.nvim to install all plugins (this may take a few minutes)"
echo "3. Restart Neovim to ensure everything is loaded properly"
echo ""
echo "💡 Your Neovim configuration includes:"
echo "   - Lazy.nvim plugin manager"
echo "   - Tokyo Night colorscheme"
echo "   - Minimap (codewindow.nvim)"
echo "   - Telescope fuzzy finder"
echo "   - Treesitter syntax highlighting"
echo "   - LSP support with auto-completion"
echo "   - Git integration (gitsigns)"
echo "   - File explorer (nvim-tree)"
echo "   - Status line (lualine)"
echo "   - Buffer line"
echo "   - Commenting and auto-pairs"
echo "   - And much more!"
echo ""
echo "🔧 Key mappings:"
echo "   - <leader>mm: Toggle minimap"
echo "   - <leader>ff: Find files"
echo "   - <leader>fg: Live grep"
echo "   - <leader>fb: Find buffers"
echo "   - <leader>e: Open file explorer"
echo "   - <leader>f: Format code"
echo "   - <leader>ca: Code actions"
echo "   - <leader>rn: Rename symbol"
echo ""
echo "📚 The leader key is set to <space>"
echo "   Most key mappings start with <leader> (space)"

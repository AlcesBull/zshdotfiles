#!/bin/bash

# Comprehensive Setup Script
# This script will install everything needed for your zsh and nvim setup

set -e

echo "🚀 Starting comprehensive setup..."
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Step 1: Check for Homebrew
echo "📦 Step 1: Checking Homebrew installation..."
BREW_FOUND=false

# Check if brew is in PATH
if command -v brew &> /dev/null; then
    BREW_FOUND=true
    echo "   ✅ Homebrew found in PATH"
# Check common installation locations
elif [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    BREW_FOUND=true
    echo "   ✅ Homebrew found at /opt/homebrew/bin/brew (added to PATH)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    BREW_FOUND=true
    echo "   ✅ Homebrew found at /usr/local/bin/brew (added to PATH)"
fi

if [[ "$BREW_FOUND" == false ]]; then
    echo ""
    echo "   ⚠️  Homebrew is not installed."
    echo "   📝 To install Homebrew, run this command in your terminal:"
    echo "      /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo ""
    echo "   After installing Homebrew, run this setup script again."
    echo "   Or, if Homebrew is installed but not in PATH, add it manually:"
    echo "      eval \"\$(/opt/homebrew/bin/brew shellenv)\"  # For Apple Silicon"
    echo "      eval \"\$(/usr/local/bin/brew shellenv)\"     # For Intel Mac"
    echo ""
    exit 1
fi

# Ensure brew is available
if ! command -v brew &> /dev/null; then
    echo "   ❌ Homebrew not available in PATH. Please add it manually."
    exit 1
fi

# Step 2: Install terminal enhancement tools
echo ""
echo "📥 Step 2: Installing terminal enhancement tools..."
tools=(
    "bat"           # Better cat with syntax highlighting
    "jq"            # JSON processor with color
    "git-delta"     # Better git diffs
    "glow"          # Markdown renderer
    "ripgrep"       # Faster grep
    "zsh-autosuggestions"  # Command suggestions
    "zsh-syntax-highlighting"  # Syntax highlighting
    "awscli"        # AWS command-line interface
    "1password-cli" # 1Password CLI (op)
)

for tool in "${tools[@]}"; do
    if brew list "$tool" &> /dev/null 2>&1; then
        echo "   ✅ $tool already installed"
    else
        echo "   📦 Installing $tool..."
        brew install "$tool" || echo "   ⚠️  Failed to install $tool (may already be installed)"
    fi
done

# Step 3: Configure Git Delta
echo ""
echo "🎨 Step 3: Configuring Git Delta..."
if command -v delta &> /dev/null; then
    git config --global core.pager delta || true
    git config --global interactive.diffFilter "delta --color-only" || true
    git config --global delta.navigate true || true
    git config --global delta.side-by-side true || true
    echo "   ✅ Git Delta configured"
else
    echo "   ⚠️  Delta not found, skipping git config"
fi

# Step 4: Install Neovim
echo ""
echo "📦 Step 4: Installing Neovim..."
if command -v nvim &> /dev/null; then
    echo "   ✅ Neovim already installed: $(nvim --version | head -n 1)"
else
    echo "   📦 Installing Neovim..."
    brew install neovim
    echo "   ✅ Neovim installed: $(nvim --version | head -n 1)"
fi

# Step 5: Install Neovim configuration
echo ""
echo "📁 Step 5: Installing Neovim configuration..."
if [[ -d "$HOME/.config/nvim" ]]; then
    echo "   📦 Backing up existing nvim config to nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup" || true
fi

mkdir -p "$HOME/.config"
cp -r "$SCRIPT_DIR/nvim-config" "$HOME/.config/nvim"
find "$HOME/.config/nvim" -type f -name "*.lua" -exec chmod 644 {} \;
echo "   ✅ Neovim configuration installed"

# Step 6: Install a Nerd Font and point Terminal.app at it. This is what makes
# the Powerline prompt separators and Neovim file icons render (otherwise they
# show as empty boxes).
echo ""
echo "🔤 Step 6: Installing Nerd Font and configuring Terminal.app..."
if brew list --cask font-meslo-lg-nerd-font &> /dev/null 2>&1; then
    echo "   ✅ MesloLGS Nerd Font already installed"
else
    echo "   📦 Installing MesloLGS Nerd Font..."
    brew install --cask font-meslo-lg-nerd-font || echo "   ⚠️  Failed to install font"
fi

# Point Terminal.app's default + startup profiles at the Nerd Font via
# AppleScript. Skipped gracefully on non-macOS or if Terminal isn't scriptable.
if [[ "$(uname)" == "Darwin" ]]; then
    if osascript <<'OSA' &> /dev/null
tell application "Terminal"
    set font name of default settings to "MesloLGSNF-Regular"
    set font name of startup settings to "MesloLGSNF-Regular"
end tell
OSA
    then
        echo "   ✅ Terminal.app font set to MesloLGS Nerd Font (open a new window to see it)"
    else
        echo "   ⚠️  Could not set Terminal.app font automatically."
        echo "      Set it manually: Terminal → Settings → Profiles → Font → MesloLGS Nerd Font"
    fi
fi

# Step 7: Install Node.js and the global CLIs that depend on it.
echo ""
echo "📦 Step 7: Installing Node.js and developer CLIs..."
if command -v node &> /dev/null; then
    echo "   ✅ Node already installed: $(node --version)"
else
    echo "   📦 Installing Node..."
    brew install node || echo "   ⚠️  Failed to install node"
fi

if command -v npm &> /dev/null; then
    npm_clis=(
        "@sourcegraph/amp"   # Amp CLI (agentic coding; pairs with amp.nvim)
        "@controlplane/cli"  # Control Plane CLI (cpln)
    )
    for pkg in "${npm_clis[@]}"; do
        echo "   📦 Installing $pkg ..."
        npm install -g "$pkg" || echo "   ⚠️  Failed to install $pkg"
    done

    # Amp companion plugin: lets Amp read Neovim LSP diagnostics. Only present
    # after amp.nvim has been fetched (first nvim launch / Lazy sync).
    amp_companion="$HOME/.local/share/nvim/lazy/amp.nvim/plugin/amp-neovim-diagnostics.ts"
    if [[ -f "$amp_companion" ]]; then
        mkdir -p "$HOME/.config/amp/plugins"
        cp "$amp_companion" "$HOME/.config/amp/plugins/"
        echo "   ✅ Amp Neovim diagnostics companion installed"
    fi
else
    echo "   ⚠️  npm not available, skipping Amp / Control Plane CLIs"
fi

# Step 8: Ensure the bat-based cat/less aliases are guarded so they don't
# break the shell when bat is missing.
echo ""
echo "🔧 Step 8: Checking .zshrc cat/less alias guard..."
if grep -q "command -v bat" ~/.zshrc; then
    echo "   ✅ .zshrc already guards cat/less behind a bat check"
elif grep -q "alias cat='bat --style=plain'" ~/.zshrc; then
    # Wrap the legacy unconditional aliases in a bat-existence check
    sed -i.bak "s/alias cat='bat --style=plain'/if command -v bat \&> \/dev\/null; then\n  alias cat='bat --style=plain'\nfi/" ~/.zshrc
    sed -i.bak "s/alias less='bat --paging=always'/  alias less='bat --paging=always'\nfi/" ~/.zshrc
    echo "   ✅ .zshrc updated"
else
    echo "   ✅ No bat aliases found to guard"
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Test cat command: cat ~/.zshrc"
echo "3. Open Neovim: nvim"
echo "4. Wait for Lazy.nvim to install all plugins (this may take a few minutes)"
echo "5. Restart Neovim to ensure everything is loaded properly"
echo ""
echo "💡 Your setup now includes:"
echo "   ✅ Terminal enhancement tools (bat, jq, git-delta, glow, ripgrep)"
echo "   ✅ Zsh autosuggestions and syntax highlighting"
echo "   ✅ AWS CLI, 1Password CLI (op)"
echo "   ✅ Node.js + Amp CLI and Control Plane CLI (cpln)"
echo "   ✅ MesloLGS Nerd Font + Terminal.app configured to use it"
echo "   ✅ Neovim with full configuration"
echo "   ✅ Fixed cat command (works even without bat)"
echo ""


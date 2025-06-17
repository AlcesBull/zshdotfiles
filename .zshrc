# Clean, portable Zsh configuration
# No Nix dependencies

# History configuration
HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.local/share/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Enable completion system
autoload -U compinit && compinit

# Set terminal title
echo -ne '\033]0;New Window\a'

settitle() {
  echo -ne '\033]0;'"$1"'\a'
}

# Source additional config files
for config_file in $HOME/.config/zsh/*.zsh; do
  [[ -r "$config_file" ]] && source "$config_file"
done

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Better alternatives (install via brew)
alias cat='bat --style=plain'  # Use bat instead of cat
alias less='bat --paging=always'  # Use bat as a pager

# Git aliases with better output
alias glog='git log --oneline --graph --color=always'
alias gstatus='git status --short --branch'
alias gdiff='git diff --color=always'

# Directory listing with colors and details
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'

# Make grep results more readable
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Utility functions for better terminal output
# Colorized log viewer
logview() {
  if command -v bat &> /dev/null; then
    bat --language=log --style=numbers,changes "$@"
  else
    less "$@"
  fi
}

# Pretty JSON viewer
json() {
  if command -v jq &> /dev/null; then
    jq -C . "$@" | less -R
  elif command -v python3 &> /dev/null; then
    python3 -m json.tool "$@" | bat --language=json
  else
    cat "$@"
  fi
}

# Tail logs with color
tailcolor() {
  tail -f "$@" | bat --paging=never --language=log
}

# Search in files with context and color
search() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: search <pattern> <files...>"
    return 1
  fi
  local pattern="$1"
  shift
  grep -n --color=always -C 3 "$pattern" "$@" | less -R
}

# Optional: Install these manually if you want the features
# For autosuggestions: brew install zsh-autosuggestions
# For syntax highlighting: brew install zsh-syntax-highlighting
# Then uncomment the lines below:
#
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Setup function to install terminal enhancement tools
setup_terminal_tools() {
  echo "🚀 Setting up terminal enhancement tools..."
  
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo "✅ Homebrew already installed"
  fi
  
  # List of tools to install
  local tools=(
    "bat"           # Better cat with syntax highlighting
    "jq"            # JSON processor with color
    "git-delta"     # Better git diffs
    "glow"          # Markdown renderer
    "ripgrep"       # Faster grep
    "zsh-autosuggestions"  # Command suggestions
    "zsh-syntax-highlighting"  # Syntax highlighting
  )
  
  echo "📥 Installing terminal tools..."
  for tool in "${tools[@]}"; do
    if brew list "$tool" &> /dev/null; then
      echo "✅ $tool already installed"
    else
      echo "📦 Installing $tool..."
      brew install "$tool"
    fi
  done
  
  echo "🎨 Setting up Git Delta..."
  # Configure git to use delta
  git config --global core.pager delta
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global delta.side-by-side true
  
  echo "✨ Setup complete! Restart your terminal or run 'source ~/.zshrc'"
  echo ""
  echo "💡 To enable zsh enhancements, add these lines to your .zshrc:"
  echo "   source \$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  echo "   source \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

# Quick setup alias
alias setup-terminal='setup_terminal_tools'

# Auto-load zsh enhancements if available
if command -v brew &> /dev/null; then
  # Load zsh-autosuggestions if installed
  if [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
  
  # Load zsh-syntax-highlighting if installed (must be last)
  if [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi 
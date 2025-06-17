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

# Optional: Install these manually if you want the features
# For autosuggestions: brew install zsh-autosuggestions
# For syntax highlighting: brew install zsh-syntax-highlighting
# Then uncomment the lines below:
#
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
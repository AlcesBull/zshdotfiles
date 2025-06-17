typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/z33amf949fpc3q4xpxqvf6vvcwkc0hdv-zsh-5.9/share/zsh/$ZSH_VERSION/help"



export ZPLUG_HOME=/Users/spencerpitman/.zplug

source /nix/store/zqkx31v6amkwn5mwzbjh7c30h5hzh7wx-zplug-2.4.2/share/zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"



if ! zplug check; then
  zplug install
fi

zplug load


# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit
source /nix/store/biphvm67x01vm4vxlbbj1yf769p3mqhm-zsh-autosuggestions-0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)







# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/Users/spencerpitman/.local/share/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


# if [[ $TERM != "dumb" ]]; then
#   eval "$(/Users/spencerpitman/.nix-profile/bin/starship init zsh)"
# fi

echo -ne '\033]0;New Window\a'

settitle() {
  echo -ne '\033]0;'"$1"'\a'
}

for config_file in $(ls $HOME/.config/zsh | grep -e '.zsh$')
do
  source "$HOME/.config/zsh/$config_file"
done


# Aliases
alias -- 'ls'='ls --color=auto'

# Named Directory Hashes


source /nix/store/dzp1vi5f0l3lblgvj33vzalmgpcwcand-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=() 
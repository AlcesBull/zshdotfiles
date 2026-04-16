autoload -Uz vcs_info

# Powerline / Nerd Font glyphs (work with WezTerm's built-in font fallback, no patching needed)
# U+E0B0 = Powerline right-pointing triangle separator
# U+E0A0 = Git branch icon
# U+F00C = check, U+F00D = times, U+F067 = plus, U+F044 = pencil, U+F128 = question
typeset -g PL_RIGHT=$'\ue0b0'
typeset -g PL_BRANCH=$'\ue0a0'
typeset -g NF_CHECK=$'\uf00c'
typeset -g NF_TIMES=$'\uf00d'
typeset -g NF_PLUS=$'\uf067'
typeset -g NF_PENCIL=$'\uf044'
typeset -g NF_QUESTION=$'\uf128'

# Enable vcs_info for git
zstyle ':vcs_info:*' enable git

# Format for the git part of the prompt
zstyle ':vcs_info:git:*' formats '%F{magenta}%B%b%f'
zstyle ':vcs_info:git:*' actionformats 'on  %b (%a)' # e.g., for rebase

# Function to get detailed git status icons (Nerd Font symbols)
get_git_status() {
  local status_str=""
  local git_status
  git_status=$(git status --porcelain=v1 2>/dev/null)

  if [[ -z "$git_status" ]]; then
    PROMPT_GIT_STATUS=" %F{green}${NF_CHECK}%f"
    return
  fi

  local has_staged=0
  local has_modified=0
  local has_deleted=0
  local has_untracked=0

  if echo "$git_status" | grep -q '^[MARCD]'; then has_staged=1; fi
  if echo "$git_status" | grep -q '^.M'; then has_modified=1; fi
  if echo "$git_status" | grep -q '^.D'; then has_deleted=1; fi
  if echo "$git_status" | grep -q '^\?\?'; then has_untracked=1; fi

  if (( has_deleted ));  then status_str+='%F{red}'${NF_TIMES}'%f'; fi
  if (( has_modified )); then status_str+='%F{yellow}'${NF_PENCIL}'%f'; fi
  if (( has_untracked )); then status_str+='%F{cyan}'${NF_QUESTION}'%f'; fi
  if (( has_staged ));   then status_str+='%F{green}'${NF_PLUS}'%f'; fi

  if [[ -n "$status_str" ]]; then
    PROMPT_GIT_STATUS=" ${status_str}"
  else
    PROMPT_GIT_STATUS=""
  fi
}


# Run vcs_info and calculate path before each prompt
precmd() {
  vcs_info
  if [[ -n ${vcs_info_msg_0_} ]]; then
    get_git_status
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n "$git_root" ]]; then
      local repo_name
      repo_name=$(basename "$git_root")
      local path_in_repo
      path_in_repo=${PWD#$git_root}
      prompt_path="${repo_name}${path_in_repo}"
    else
      prompt_path="%~"
    fi
    # Powerline: path | branch+status | prompt
    PROMPT="%K{blue}%F{white} %B${prompt_path}%b %f%k%F{blue}%K{magenta}${PL_RIGHT}%f%k%K{magenta}%F{white} ${PL_BRANCH} ${vcs_info_msg_0_}${PROMPT_GIT_STATUS} %f%k%F{magenta}%K{green}${PL_RIGHT}%f%k%F{green}${PL_RIGHT}%f "
  else
    prompt_path="%~"
    PROMPT_GIT_STATUS=""
    # Powerline: path | prompt (no git)
    PROMPT="%K{blue}%F{white} %B${prompt_path}%b %f%k%F{blue}%K{default}${PL_RIGHT}%f%k%F{green}${PL_RIGHT}%f "
  fi
}

# Make sure prompt substitutions are on
setopt PROMPT_SUBST 
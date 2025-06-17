autoload -Uz vcs_info

# Enable vcs_info for git
zstyle ':vcs_info:*' enable git

# Format for the git part of the prompt
zstyle ':vcs_info:git:*' formats '%F{magenta}%B %b%b%f'
zstyle ':vcs_info:git:*' actionformats 'on  %b (%a)' # e.g., for rebase

# Function to get detailed git status icons
get_git_status() {
  local status_str=""
  local git_status
  git_status=$(git status --porcelain=v1 2>/dev/null)

  if [[ -z "$git_status" ]]; then
    # Directory is clean, show a green checkmark
    PROMPT_GIT_STATUS=" %F{green}✔%f"
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

  # Assemble the status string. Icons inspired by Starship.
  # ✘: deleted, !: modified, ?: untracked, ✔: staged
  if (( has_deleted ));  then status_str+='%F{red}✘%f'; fi
  if (( has_modified )); then status_str+='%F{yellow}!%f'; fi
  if (( has_untracked ));then status_str+='%F{cyan}?%f'; fi
  if (( has_staged ));   then status_str+='%F{green}✔%f'; fi

  # Add a leading space if there are any icons
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
    # We are in a git repo
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
      # Fallback to ~ if git command fails
      prompt_path="%~"
    fi
  else
    # Not in a git repo, show path with ~
    prompt_path="%~"
    PROMPT_GIT_STATUS="" # Clear git status when not in a repo
  fi

  # Define the prompt inside precmd to re-evaluate it every time
  PROMPT="%F{blue}%B${prompt_path}%b%f %F{cyan} on%f ${vcs_info_msg_0_}${PROMPT_GIT_STATUS}
%B%F{green}➜%b%f "
}

# Make sure prompt substitutions are on
setopt PROMPT_SUBST 
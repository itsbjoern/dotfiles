_git_super_status() {
    precmd_update_git_vars

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
      STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"

      if [ "$GIT_AHEAD" -eq "0" ] && [ "$GIT_BEHIND" -eq "0" ] && [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
      else
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
      fi

      if [ "$GIT_BEHIND" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND%{${reset_color}%}"
      fi
      if [ "$GIT_AHEAD" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD%{${reset_color}%}"
      fi

      if [ "$GIT_STAGED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED%{${reset_color}%}"
      elif [ "$GIT_CHANGED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED%{${reset_color}%}"
      elif [ "$GIT_UNTRACKED" -ne "0" ]; then
          STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
      fi

      STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
      echo "$STATUS"
    fi
}

PROMPT="%(?:%{$fg_bold[green]%}➜ %n:%{$fg_bold[red]%}➜ %n)"
PROMPT+='$(virtualenv_prompt_info)'
PROMPT+=' %{$fg[cyan]%}[%~]%{$reset_color%} $(_git_super_status)'
RPROMPT=""

ZSH_THEME_VIRTUALENV_PREFIX="@"
ZSH_THEME_VIRTUALENV_SUFFIX='\0'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[yellow]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CONFLICTS=""
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[yellow]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}↑"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""
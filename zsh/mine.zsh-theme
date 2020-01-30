PROMPT="%(?:%{$fg_bold[green]%}➜ %n:%{$fg_bold[red]%}➜ %n)"
PROMPT+='$(virtualenv_prompt_info)'
PROMPT+=' %{$fg[cyan]%}[%~]%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_VIRTUALENV_PREFIX="@"
ZSH_THEME_VIRTUALENV_SUFFIX='\0'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}[%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} %{$fg[yellow]%}✗]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}]"

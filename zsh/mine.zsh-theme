PROMPT="%(?:%{$fg_bold[green]%}➜ %n:%{$fg_bold[red]%}➜ %n)"
PROMPT+='$(virtualenv_prompt_info)'
PROMPT+=' %{$fg[cyan]%}[%~]%{$reset_color%} $(git_super_status)'
RPROMPT=""

ZSH_THEME_VIRTUALENV_PREFIX="@"
ZSH_THEME_VIRTUALENV_SUFFIX='\0'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[yellow]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg[green]%}✗"
ZSH_THEME_GIT_PROMPT_CONFLICTS=""
ZSH_THEME_GIT_PROMPT_CHANGED=" %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""

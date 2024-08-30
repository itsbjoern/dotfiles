export PROMPT="%(?:%{$fg_bold[cyan]%}:%{$fg_bold[red]%})▸%{$reset_color%} "
export EDITOR='vim'

# set where virtual environments will live
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/code
export PYTHONWARNINGS="ignore"


# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALVENV_STATUS=$WORKON_HOME
# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true

export HOMEBREW_PREFIX=$(brew --prefix)
export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:/usr/local/sbin:$PATH"

export HISTFILE="$ZDOTDIR/.zsh_history"

# pnpm
export PNPM_HOME="/Users/$USER/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Track interactions of TMUX panes and update SSH_AUTH_SOCK
_update_ssh_agent() {
    local var
    var=$(tmux show-environment |grep '^SSH_AUTH_SOCK=')
    if [ "$?" -eq 0 ]; then
        eval "$var"
    fi
}

_set_pane_env() {
  mkdir -p ~/.tmux/.panes;
  env >~/.tmux/.panes/$TMUX_PANE;
}

if [[ -n "$TMUX" ]]; then
  add-zsh-hook precmd _set_pane_env
  add-zsh-hook precmd _update_ssh_agent
fi

# my-backward-delete-word() {
#     local WORDCHARS=${WORDCHARS/\//}
#     zle backward-delete-word
# }
# zle -N my-backward-delete-word
# bindkey '^[' my-backward-delete-word

bindkey '^[[Z' reverse-menu-complete

# Should be called before compinit
zmodload zsh/complist
fpath=( ~/.config/zsh/functions ~/.config/zsh/completions $fpath )

autoload -Uz $fpath[1]/*(.:t)
autoload -Uz $fpath[2]/*(.:t)
autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files

source ~/.config/zsh/set-term-var.zsh
source ~/.config/zsh/completions.zsh
source ~/.config/zsh/aliases/general.zsh
source ~/.config/zsh/aliases/git.zsh

precmd_functions+=(set_venv_vars)

setopt HIST_SAVE_NO_DUPS
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# https://github.com/zsh-users/zsh-autosuggestions/issues/515
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh




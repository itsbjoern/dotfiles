# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_TITLE="true"
# Path to your oh-my-zsh installation.
export ZSH="/Users/bjoern/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mine"


plugins=(
  cp 
  brew 
  macos 
  virtualenv 
  git 
)

source $ZSH/oh-my-zsh.sh

# zstyle ':completion:*:default' list-colors "di=1;36"" ln=35"" so=32"" pi=33"" ex=31"" bd=34;46"" cd=34;43"" su=30;41"" sg=30;46"" tw=30;42"" ow=30;43"
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' insert-tab false
zstyle ':completion:::*:default' menu yes=0 select=0
zstyle ':completion:::*:default' expand suffix

# source ~/.iterm2_shell_integration.zsh

# my-backward-delete-word() {
#     local WORDCHARS=${WORDCHARS/\//}
#     zle backward-delete-word
# }
# zle -N my-backward-delete-word
# bindkey '^[' my-backward-delete-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
# https://github.com/zsh-users/zsh-autosuggestions/issues/515
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# set where virutal environments will live
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/code
export PYTHONWARNINGS="ignore"
export DISABLE_UPDATE_PROMPT=true

export EDITOR='vim'

# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALVENV_STATUS=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON="$HOMEBREW_PREFIX/bin/python3"
export VIRTUALENVWRAPPER_VIRTUALENV="$HOMEBREW_PREFIX/bin/virtualenv"
export VIRTUALENVWRAPPER_HOOK_DIR="$(dirname $(readlink ~/.zshrc))/../venv-hooks"

# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r $HOMEBREW_PREFIX/bin/virtualenvwrapper.sh ]]; then
    source $HOMEBREW_PREFIX/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

alias o=open
alias c=clear && printf '\e[3J'
alias wo=workon
alias python2="$HOMEBREW_PREFIX/bin/python2"
alias ghpr="gh pr create --base $(git_develop_branch) -w"

unalias brew 2>/dev/null
brewser=$(stat -f "%Su" $(which brew))
alias brew='sudo -Hu '$brewser' brew'
# Any additional user needs to be a sudo user as follow:
# <user>        ALL = (<brewser>) NOPASSWD: /opt/homebrew/bin/brew

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

function diff() {
  [[ ! -z "$1" ]] && B="$1" || B="$(git_develop_branch)"
  git merge-base $(git branch --show-current) $B | xargs git diff --ignore-all-space
}

function a() {
  if [ -z "$VIRTUAL_ENV" ]; then
      echo "no active VIRTUAL ENV"
      return 1
  fi

  # if .project file exists read content
  if [ -f "$VIRTUAL_ENV/.project" ]; then
    PROJECT=`cat "$VIRTUAL_ENV/.project"`
    if [ -d "$PROJECT" ]; then
      cd "$PROJECT"
      return 0
    else
      echo "project directory '$PROJECT' does not exist"
      return 1
    fi
  fi

  if [ ! -d "$VIRTUAL_ENV/src" ]; then
      mkdir "$VIRTUAL_ENV/src"
  fi

  VENV_STATUS=`basename $VIRTUAL_ENV`
  if [ -d "$VIRTUAL_ENV/src/$VENV_STATUS" ]; then
    cd "$VIRTUAL_ENV/src/$VENV_STATUS"
  else
    cd "$VIRTUAL_ENV/src"
  fi
}

export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:/usr/local/sbin:$PATH"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

function auto_workon() {
  if [ -n "$VIRTUAL_ENV" ]; then
    return
  fi

  GIT_FOLDER=$(git rev-parse --show-toplevel) 2> /dev/null  &> /dev/null
  if [ -n "$GIT_FOLDER" ]; then
    workon $(basename "$GIT_FOLDER") 2> /dev/null
  fi
}

unsetopt inc_append_history
unsetopt share_history

# pnpm
export PNPM_HOME="/Users/bjoern/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

function set_all_env_vars() {
  DIR_STATUS=$(pwd)

  if [ -n "$VIRTUAL_ENV" ]; then
    VENV_STATUS=`basename "$VIRTUAL_ENV"`
    ENV_FOLDER="$VIRTUAL_ENV/src/$VENV_STATUS"

    if [ -f "$VIRTUAL_ENV/.project" ]; then
      ENV_FOLDER=`cat "$VIRTUAL_ENV/.project"`
      VENV_STATUS="$VENV_STATUS*"
    fi

    if [ -d "$ENV_FOLDER" ]; then
      if ! [ "$ENV_FOLDER" = "$DIR_STATUS" ]; then
        DIR_STATUS="@/$(grealpath --relative-to=$ENV_FOLDER $DIR_STATUS)"
      else
        DIR_STATUS="@"
      fi
    else
      if ! [ "$VIRTUAL_ENV/src" = "$DIR_STATUS" ]; then
        DIR_STATUS="@/$(grealpath --relative-to=$VIRTUAL_ENV/src $DIR_STATUS)"
      else
        DIR_STATUS="@"
      fi
    fi
    VENV_STATUS="$VENV_STATUS"
  else
    VENV_STATUS=""
    if ! [ "$DIR_STATUS" = "/Users/$USER" ]; then
      DIR_STATUS="~/$(grealpath --relative-to=/Users/$USER $DIR_STATUS)"
    else
      DIR_STATUS="~"
    fi
  fi

  IS_IN_GIT=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  if [ "$IS_IN_GIT" = "true" ]; then
    GIT_BRANCH_STATUS=$(git rev-parse --abbrev-ref HEAD)
  else
    GIT_BRANCH_STATUS=""
  fi

  # iterm2_set_user_var virtualEnv "$VENV_STATUS"
  # iterm2_set_user_var currDir "$DIR_STATUS"

  CUSTOM_DISPLAY_PATH="$DIR_STATUS"

  if [ -n "$VENV_STATUS" ]; then
    CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH - $VENV_STATUS"
  fi
  if [ -n "$GIT_BRANCH_STATUS" ]; then
    CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH ($GIT_BRANCH_STATUS)"
  fi

  export VENV_STATUS="$VENV_STATUS"
  export GIT_BRANCH_STATUS="$GIT_BRANCH_STATUS"
  export DIR_STATUS="$DIR_STATUS"
  export CUSTOM_DISPLAY_PATH="$CUSTOM_DISPLAY_PATH"
}
precmd_functions+=(set_all_env_vars)

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

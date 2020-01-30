# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/bjoern/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mine"

plugins=(
  git 
  cp 
  brew 
  osx 
  virtualenv
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*:default' list-colors "di=1;36" "ln=35" "so=32" "pi=33" "ex=31" "bd=34;46" "cd=34;43" "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' insert-tab false
zstyle ':completion:::*:default' menu yes=0 select=0
zstyle ':completion:::*:default' expand suffix

my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '^[' my-backward-delete-word

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# set where virutal environments will live
export WORKON_HOME=$HOME/code

# ensure all new environments are isolated from the site-packages directory
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

alias o=open
alias c=clear && printf '\e[3J'
alias mongo='docker exec -ti mongodb mongo'
alias pcalc='python -i -c "from __future__ import division"'
alias python="/usr/bin/python3"
alias python2="/usr/bin/python2"

function a() {
  if [ -z "$VIRTUAL_ENV" ]; then
      echo "no active VIRTUAL ENV"
      return 1
  fi

  if [ ! -d "$VIRTUAL_ENV/src" ]; then
      mkdir "$VIRTUAL_ENV/src"
  fi
  cd "$VIRTUAL_ENV/src"
}

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000

autoload -Uz compinit
compinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

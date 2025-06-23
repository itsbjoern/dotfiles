
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
alias o=open
alias wo=workon
function woa() {
  workon $1; a;
}

alias o=open
alias c=clear && printf '\e[3J'
alias wo=workon
alias python2="$HOMEBREW_PREFIX/bin/python2"


alias ghpr="gh pr create --base ${git_develop_branch:=development} -w"
function diff() {
  [[ ! -z "$1" ]] && B="$1" || B="$(git_develop_branch)"
  git merge-base $(git branch --show-current) $B | xargs git diff --ignore-all-space
}


# Any additional user needs to be a sudo user as follow:
# <user>        ALL = (<brewser>) NOPASSWD: /opt/homebrew/bin/brew
brewser=$(stat -f "%Su" $(which $HOMEBREW_PREFIX/bin/brew))
unalias brew 2>/dev/null
alias brew='sudo -Hu '$brewser' brew'

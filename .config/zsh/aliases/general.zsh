
alias o=open
alias o=open
alias c=clear && printf '\e[3J'
alias python2="$HOMEBREW_PREFIX/bin/python2"


alias ghpr="gh pr create --base ${git_develop_branch:=development} -w"
function diff() {
  [[ ! -z "$1" ]] && B="$1" || B="$(git_develop_branch)"
  git merge-base $(git branch --show-current) $B | xargs git diff --ignore-all-space
}


# Any additional user needs to be a sudo user as follow:
# <user>        ALL = (<user>) NOPASSWD: /opt/homebrew/bin/brew, /usr/sbin/installer, /bin/launchctl

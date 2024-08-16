unalias brew 2>/dev/null
set brewser $(stat -f "%Su" $(which brew))
alias brew='sudo -Hu '$brewser' brew'
alias o=open
alias wo=workon
alias python2="$HOMEBREW_PREFIX/bin/python2"

abbr -a fish-reload 'source ~/.config/fish/**/*.fish'

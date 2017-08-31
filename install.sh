#!/bin/bash

if [  ! -d "bash/bash-me" ] ;then
  cd bash
  git clone git@github.com:BFriedrichs/bash-me.git
  cd ..
fi

echo Symlinking dotfiles...
rm -rf ~/.bash_profile
ln -s "$PWD/bash/bash_profile" ~/.bash_profile

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

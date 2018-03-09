#!/bin/bash

if [  ! -d "bash/bash-me" ] ;then
  cd bash
  git clone git@github.com:BFriedrichs/bash-me.git
  cd ..
fi

if [ -f ~/.git-completion.bash ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

echo Symlinking dotfiles...
rm -rf ~/.bash_profile
rm -rf ~/.gitignore-global
rm -rf ~/.gitconfig

ln -s "$PWD/bash/bash_profile" ~/.bash_profile
ln -s "$PWD/extras/.gitconfig" ~/.gitconfig
ln -s "$PWD/extras/.gitignore-global" ~/.gitignore-global
git config --global core.excludesfile '~/.gitignore-global'
#!/bin/bash

cd bash
git clone git@github.com:BFriedrichs/bash-me.git
cd ..

echo Symlinking dotfiles...
rm -rf ~/.bash_profile
ln -s "$PWD/bash/bash_profile" ~/.bash_profile

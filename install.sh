#!/bin/bash

echo Symlinking dotfiles...
rm -rf ~/.bash_profile
ln -s "$PWD/bash/bash_profile" ~/.bash_profile

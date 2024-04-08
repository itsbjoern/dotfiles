which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not found... Installing"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

which -s realpath
if [[ $? != 0 ]] ; then
    echo "Coreutils not found... Installing"
    brew install coreutils
fi

which -s tmux
if [[ $? != 0 ]] ; then
    echo "tmux not found... Installing"
    brew install tmux
fi

if [  ! -d "/Users/$USER/.oh-my-zsh" ] ;then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [  ! -d "/Users/$USER/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] ;then
  sh -c "git clone https://github.com/zsh-users/zsh-autosuggestions /Users/$USER/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [  ! -d "/Users/$USER/.tmux/plugins/tpm" ] ;then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [  ! -d "/Users/$USER/.tmux/fonts" ] ;then
  git clone https://github.com/powerline/fonts.git --depth=1 ~/.tmux/fonts
  sh -c "~/.tmux/fonts/install.sh"
fi

mkdir -p ~/.tmux

rm -rf ~/.zshrc
rm -rf ~/.gitignore-global
rm -rf ~/.gitconfig
rm -rf ~/.oh-my-zsh/themes/mine.zsh-theme
rm -rf ~/.tmux.conf
rm -rf ~/.tmux/status

ln -s "$PWD/zsh/zsh_profile.zshrc" ~/.zshrc
ln -s "$PWD/zsh/mine.zsh-theme" ~/.oh-my-zsh/themes/mine.zsh-theme
ln -s "$PWD/extras/.gitconfig" ~/.gitconfig
ln -s "$PWD/extras/.gitignore-global" ~/.gitignore-global
ln -s "$PWD/tmux/.tmux.conf" ~/.tmux.conf
ln -s "$PWD/tmux/status" ~/.tmux/status

git config --global core.excludesfile '~/.gitignore-global'

sh -c "~/.tmux/plugins/tpm/bin/install_plugins"
sh -c "~/.tmux/plugins/tpm/bin/update_plugins all"

echo "\n* Done! To enable all changes restart shell or run:"
echo "    source ~/.zshrc\n"

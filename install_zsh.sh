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

if [  ! -d "/Users/$USER/.oh-my-zsh" ] ;then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [  ! -d "/Users/$USER/.oh-my-zsh/custom/plugins/git-open" ] ;then
  sh -c "git clone https://github.com/paulirish/git-open.git /Users/$USER/.oh-my-zsh/custom/plugins/git-open"
fi

rm -rf ~/.zshrc
rm -rf ~/.gitignore-global
rm -rf ~/.gitconfig
rm -rf ~/.oh-my-zsh/themes/mine.zsh-theme

ln -s "$PWD/zsh/zsh_profile.zshrc" ~/.zshrc
ln -s "$PWD/zsh/mine.zsh-theme" ~/.oh-my-zsh/themes/mine.zsh-theme
ln -s "$PWD/extras/.gitconfig" ~/.gitconfig
ln -s "$PWD/extras/.gitignore-global" ~/.gitignore-global
git config --global core.excludesfile '~/.gitignore-global'

echo "\n* Done! To enable all changes restart shell or run:"
echo "    source ~/.zshrc\n"

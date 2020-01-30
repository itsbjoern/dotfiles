
if [  ! -d "/Users/$USER/.oh-my-zsh" ] ;then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

rm -rf ~/.zshrc
rm -rf ~/.gitignore-global
rm -rf ~/.gitconfig
rm -rf ~/.oh-my-zsh/themes/mine.zsh-theme

ln -s "$PWD/zsh/zsh_profile" ~/.zshrc
ln -s "$PWD/zsh/mine.zsh-theme" ~/.oh-my-zsh/themes/mine.zsh-theme
ln -s "$PWD/extras/.gitconfig" ~/.gitconfig
ln -s "$PWD/extras/.gitignore-global" ~/.gitignore-global
git config --global core.excludesfile '~/.gitignore-global'

echo "\n* Done! To enable all changes restart shell or run:"
echo "    source ~/.zshrc\n"

echo "";
echo "Linking files..."
ln -sfvn $(pwd)/.zshenv ~/.zshenv
ln -sfvn $(pwd)/.config ~/.config
ln -sfvn $(pwd)/.pip ~/.pip
ln -sfvn $(pwd)/.gitconfig ~/.gitconfig
ln -sfvn $(pwd)/.gitignore-global ~/.gitignore-global

source ~/.config/zsh/.zshrc

echo "";
echo "Linking files..."
ln -sfvn $(pwd)/.zshenv ~/.zshenv
ln -sfvn $(pwd)/.config ~/.config
ln -sfvn $(pwd)/.pip ~/.pip
ln -sfvn $(pwd)/.gitconfig ~/.gitconfig
ln -sfvn $(pwd)/.gitignore-global ~/.gitignore-global
ln -sfvn $(pwd)/.config/aerospace/.aerospace.toml ~/.aerospace.toml

source ~/.config/zsh/.zshrc

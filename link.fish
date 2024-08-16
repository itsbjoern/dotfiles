echo "";
echo "Linking files..."
ln -sfv $(pwd)/.config ~/.config
ln -sfv $(pwd)/.pip ~/.pip
ln -sfv $(pwd)/.gitconfig ~/.gitconfig
ln -sfv $(pwd)/.gitignore-global ~/.gitignore-global
source ~/.config/fish/**/*.fish
echo "";
echo "Linking files..."
ln -sfvn $(pwd)/.config ~/.config
ln -sfvn $(pwd)/.pip ~/.pip
ln -sfvn $(pwd)/.gitconfig ~/.gitconfig
ln -sfvn $(pwd)/.gitignore-global ~/.gitignore-global
source ~/.config/fish/**/*.fish

# sudo chgrp -R everyone "/Applications/Visual Studio Code.app"
# sudo chmod -R g+w "/Applications/Visual Studio Code.app"

# Set wezterm icons
cp assets/wezterm.icns /Applications/WezTerm.app/Contents/Resources/terminal.icns
rm /var/folders/*/*/*/com.apple.dock.iconcache
rm -r /var/folders/*/*/*/com.apple.iconservices*
killall Dock

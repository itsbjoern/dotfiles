#!/bin/zsh

# Ensure env management functions are available
if [ -f "$HOME/.config/zsh/envs.zsh" ]; then
	source "$HOME/.config/zsh/envs.zsh"
fi
if [ -f "$HOME/.config/zsh/functions/mkenv" ]; then
	source "$HOME/.config/zsh/functions/mkenv"
fi

target_dir="$1"

if [ -z "$target_dir" ]; then
	echo "Usage: $0 <directory>" >&2
	exit 1
fi

if [ ! -d "$target_dir" ]; then
	echo "Error: '$target_dir' is not a directory" >&2
	exit 1
fi

setopt null_glob

# Collect subdirectories in the target directory
dirs=("$target_dir"/*(/))

if [ ${#dirs[@]} -eq 0 ]; then
	echo "No subdirectories found in '$target_dir'" >&2
	exit 0
fi

for dir in "${dirs[@]}"; do
	# Remove trailing slash to get folder name
	folder_name="${dir%/}"
	folder_name="${folder_name##*/}"
	abs_path="$(cd "$dir" && pwd)"
	echo "Creating env for $folder_name at $abs_path"
	mkenv "$folder_name" --link "$abs_path"
done

#!/bin/zsh

# Iterate over each folder in the current directory
for dir in */; do
	# Remove trailing slash to get folder name
	folder_name="${dir%/}"
	abs_path="$(cd "$dir" && pwd)"
	echo "Creating virtualenv for $folder_name at $abs_path"
	mkvirtualenv -n "$folder_name" -l "$abs_path"
done

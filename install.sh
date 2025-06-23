#!/usr/bin/env bash

# Install command-line tools using Homebrew.
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew not found... Installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
BREW_PREFIX=$(brew --prefix)
HOMEBREW_PREFIX="/opt/homebrew"
HOMEBREW_CELLAR="/opt/homebrew/Cellar"
HOMEBREW_REPOSITORY="/opt/homebrew"

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew install python

ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Remove outdated versions from the cellar.
brew cleanup


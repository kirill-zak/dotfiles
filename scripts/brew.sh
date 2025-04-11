#!/bin/sh

echo "Start to install brew packages"

PKG_LIST=(
    # media
    ffmpeg
    flac
    x264
    x265
    yt-dlp
    # tools
    git
    # utility
    bat
    keepassxc
    jq
    tmux
    tree
)

PKG_CASK_LIST=(
    # media
    eqmac
    vlc
    # dev tools
    vscodium
    # utility
    ghostty
)

if test ! $(which brew); then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

for PKG in "${PKG_LIST[@]}"; do
    brew install "${PKG}"
done

for PKG_CASK in "${PKG_CASK_LIST[@]}"; do
    brew install --cask "${PKG_CASK}"
done

echo "Brew packages installed successfully"

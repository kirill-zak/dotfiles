#!/bin/bash

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

#########################
##   Variables part    ##
#########################

# Make sure important variables exist if not already defined
#
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"

## Repository path for dotfiles
DOTFILES_REPO_PATH="${HOME}/Projects/github.com/kirill-zak"
DOTFILES_PATH="${DOTFILES_REPO_PATH}/dotfiles"

########################
##    Prepare part    ##
########################

## Check repository path 
if [ ! -d "${DOTFILES_REPO_PATH}" ]; then
    echo "create project repository directory"

    mkdir -p "${DOTFILES_REPO_PATH}"
    if [ ! $? -eq 0 ]; then
        echo "create directory for project repository failed!"
        exit 1
    fi
fi

## Check on existing of git
command_exists git || {
    echo "git is not installed"
    exit 1
}

cd "${DOTFILES_REPO_PATH}"

#########################
##   Repository part   ##
#########################

if [ ! -d "${DOTFILES_PATH}" ]; then
    echo "clone dotfiles repository"

    git clone git@github.com:kirill-zak/dotfiles.git

    if [ ! $? -eq 0 ]; then
        echo "clone repository failed - check permissions!"
        exit 1
    fi
else
    echo "pull last version"

    cd "${DOTFILES_PATH}"

    git checkout master
    if [ ! $? -eq 0 ]; then
        echo "check on master branch failed!"
        exit 1
    fi

    git pull
    if [ ! $? -eq 0 ]; then
        echo "pull last version failed - check permissions!"
        exit 1
    fi
fi

##########################
##   Run setup script   ##
##########################

sh -c "${DOTFILES_PATH}/scripts/setup.sh"

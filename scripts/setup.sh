#!/bin/sh

#########################
##    Init section     ##
#########################
## Directory for setup script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"

## Include common.sh
source "${SCRIPT_DIR}/common.sh"

#########################
##     Var section     ##
#########################

## is overwrite section
IS_OVERWRITE=false

## Dotfiles config path
DOTFILES_CONFIG_PATH="${HOME}/.config"

## Scripts config path
SCRIPT_CONFIG_PATH="${SCRIPT_DIR}/../config/"

##############################
##  Perform setup section   ##
##############################

## Dotfiles config path
if [ ! -d "${DOTFILES_CONFIG_PATH}" ]; then
    echo "Create config directory for dotfiles"

    mkdir -p "${DOTFILES_CONFIG_PATH}"

    if [ ! $? -eq 0 ]; then
        echo "Create config directory for dotfiles failed!"
        exit 1
    fi
fi

source "${SCRIPT_DIR}/config.sh"

## Perform configuration for MacOS section
if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Brewing all the things"
    source "${SCRIPT_DIR}/brew.sh"
fi

source "${SCRIPT_DIR}/zsh.sh"

## Set zsh as default shell
echo "Configuring zsh as default shell"
chsh -s $(which zsh)

echo "Successfully end of setup dotfiles!"
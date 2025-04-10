#!/bin/sh

#########################
##    Vars section     ##
#########################

## zshrc config path
ZSHRC_PATH="${HOME}/.zshrc"

## oh-my-zsh path
OMZ_PATH="${HOME}/.oh-my-zsh"

#########################
##  Insall oh-my-zsh   ##
#########################

if [ ! -d "${OMZ_PATH}" ]; then
    echo "install oh-my-zsh"

    exit 0
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

######################################
##  Make zsh env config dotfiles    ##
######################################

# ZSH config dotfiles dir
ZSH_EVN_PATH="${DOTFILES_CONFIG_PATH}/zsh_env"
SCRIPT_ZSH_ENV_PATH="${SCRIPT_CONFIG_PATH}/zsh_env"

## Check zsh env config dotfiles
if [ ! -d "${ZSH_EVN_PATH}" ]; then
    echo "Create zsh env directory for config dotfiles"

    mkdir -p "${ZSH_EVN_PATH}"

    if [ ! $? -eq 0 ]; then
        echo "Create zsh env directory for config dotfiles failed!"
        exit 1
    fi
fi

## Copy zsh aliases config dotfile
cp "${SCRIPT_ZSH_ENV_PATH}/aliases" "${ZSH_EVN_PATH}/aliases"

## Copy zsh go export config dotfile
cp "${SCRIPT_ZSH_ENV_PATH}/go" "${ZSH_EVN_PATH}/go"

#####################
##  Modify zshrc   ##
#####################

## Set zsh env path var
if ! grep -q "ZSH_ENV_PATH" "${ZSHRC_PATH}"; then

  if grep -q 'autoload -U compinit; compinit' "${ZSHRC_PATH}"; then
      sed -i.bak '/autoload -U compinit; compinit/i\
ZSH_ENV_PATH="${HOME}/.config/zsh_env"\


  ' "${ZSHRC_PATH}"
  else
      echo 'ZSH_ENV_PATH="${ZSH_EVN_PATH}"\n' >> "${ZSHRC_PATH}"
  fi

fi

## Load aliases
if ! grep -q 'source "${ZSH_ENV_PATH}/aliases' "${ZSHRC_PATH}"; then

  if grep -q 'autoload -U compinit; compinit' "${ZSHRC_PATH}"; then
        sed -i.bak '/autoload -U compinit; compinit/i\
source "${ZSH_ENV_PATH}/aliases"\


  ' "${ZSHRC_PATH}"
  else
      echo 'source "${ZSH_ENV_PATH}/aliases"\n' >> "${ZSHRC_PATH}"
  fi

fi

## Load go export
if ! grep -q 'source "${ZSH_ENV_PATH}/go' "${ZSHRC_PATH}"; then

  if grep -q 'autoload -U compinit; compinit' "${ZSHRC_PATH}"; then
        sed -i.bak '/autoload -U compinit; compinit/i\
source "${ZSH_ENV_PATH}/go"\


  ' "${ZSHRC_PATH}"
  else
      echo 'source "${ZSH_ENV_PATH}/go"\n' >> "${ZSHRC_PATH}"
  fi

fi

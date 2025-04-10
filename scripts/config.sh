#!/bin/sh

CONFIG_LIST=(
    bat
)

echo "Start to copy dot config failes"

for DOT_CONFIG in "${CONFIG_LIST[@]}"; do
    cp -r "${SCRIPT_CONFIG_PATH}/${DOT_CONFIG}" "${DOTFILES_CONFIG_PATH}/${DOT_CONFIG}"
done

echo "Dot config files was copied successfully"

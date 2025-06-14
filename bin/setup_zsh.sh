#!/bin/bash

# ensure curl is installed
if ! command -v git &> /dev/null; then
    echo "[ERROR] Curl is not installed. It is required for this script!"
    exit 1
fi

# ensure git is installed
if ! command -v git &> /dev/null; then
    echo "[ERROR] Git is not installed. It is required for this script!"
    exit 1
fi

# ensure zsh is installed
if ! command -v git &> /dev/null; then
    echo "[ERROR] Zsh is not installed. It is required for this script!"
    exit 1
fi

# TODO:
# clean up zsh configuration files if they exist or ask
# before deletion

# set up zsh as default shell
if [ -z "$SHELL" ] || [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as the default shell"
    chsh -s "$(which zsh)"
    
    # on any failure
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to set up zsh as the default shell"
        echo "[ERROR] Please visit below to manually set it up"
        echo "https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-6-set-up-zsh-as-default"
    fi
    
    echo "[SUCCESS] Zsh is now the default shell"
else
    echo "Zsh is already the default shell"
fi

# install oh-my-zsh
echo ""
echo "Installing oh-my-zsh"

# push it to background and wait until finish
nohup sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
pid=$!
wait $pid

# on any failure
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to install on-my-zsh"
    exit 1
fi

echo "[SUCCESS] Oh-my-zsh is now installed"

# install plugins
# TODO: ask if user wants to install plugins

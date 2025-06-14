#!/bin/bash

set -e

# ensure curl is installed
if ! command -v curl &> /dev/null; then
    echo "[ERROR] Curl is not installed. It is required for this script!"
    exit 1
fi

# ensure git is installed
if ! command -v git &> /dev/null; then
    echo "[ERROR] Git is not installed. It is required for this script!"
    exit 1
fi

# ensure zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "[ERROR] Zsh is not installed. It is required for this script!"
    exit 1
fi

# set up zsh as default shell
if [ -z "$SHELL" ] || [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as the default shell"
    #chsh -s "$(which zsh)"
    
    # on any failure
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to set up zsh as the default shell"
        echo "[ERROR] Please visit below to manually set it up"
        echo "https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-6-set-up-zsh-as-default"
        exit 1
    fi
    
    echo "[SUCCESS] Zsh is now the default shell"
else
    echo "Zsh is already the default shell"
fi

# install oh-my-zsh
echo ""
echo "Installing oh-my-zsh"

# push it to background and wait until finish
nohup sh -c "$(curl -fsSL \
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    > /dev/null 2>&1 1

pid=$!
wait $pid

# on any failure
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to install on-my-zsh"
    exit 1
fi

echo "[SUCCESS] Oh-my-zsh is now installed"


# clean up zsh configurations if they exist or ask
# before deletion

rm -rf "$HOME/.config/oh-my-zsh"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.zshenv"
rm -rf "$HOME/.config/zsh"

# move to correct directories
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.config/oh-my-zsh"

cp dots/zsh/.zshrc "$HOME/.config/zsh"
cp dots/zsh/.zsh_aliases "$HOME/.config/zsh"
cp dots/zsh/.zshenv "$HOME"

cp -a ~/.oh-my-zsh/. "$HOME/.config/oh-my-zsh/"
rm -rf "$HOME/.oh-my-zsh"

# install plugins
# TODO: ask if user wants to install plugins

git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/plugins/zsh-syntax-highlighting

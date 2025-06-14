# zsh env


# env

    export XDG_CONFIG_HOME="$HOME/.config"


# .zshrc, etc., location

    export ZDOTDIR="$HOME/.config/zsh"


# text editor

    export EDITOR="nvim"


# history settings

    export HISTFILE="$HOME/.config/zsh/.zsh_history"
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
    setopt INC_APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt hist_ignore_dups

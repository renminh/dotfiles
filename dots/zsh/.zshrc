# zshrc


# env

    export TMUX_CONF=~/.config/tmux/tmux.conf


# including aliases

    [ -f "$HOME/.config/zsh/.zsh_aliases" ] && source "$HOME/.config/zsh/.zsh_aliases"


# move .zscompdump files into hidden directory
    
    autoload -Uz compinit
    compinit -d ~/.config/zsh/.zcompdump


# zsh and oh-my-zsh related

    export ZSH="$HOME/.config/oh-my-zsh"

    ZSH_THEME="geoffgarside"

    plugins=(
	    git
	    zsh-autosuggestions
	    zsh-syntax-highlighting
    )

    source $ZSH/oh-my-zsh.sh

    # zsh-autosuggest config
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

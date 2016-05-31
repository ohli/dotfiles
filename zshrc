# aliases
if [[ -f ~/.aliases ]]; then
    source ~/.aliases
fi

# prompt
autoload -U promptinit && promptinit

if [[ -n "$DISPLAY" ]]; then
    if [[ -r ~/.powerline/bindings/zsh/powerline.zsh ]]; then
        source ~/.powerline/bindings/zsh/powerline.zsh
    fi
else
    export PS1="%n@%m %B%~%b$ "
fi

# completion
autoload -U compinit && compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%Bsorry, no matches for: %d%b'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

setopt completealiases
setopt correctall

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE

setopt hist_ignore_space
setopt hist_ignore_all_dups

# misc
setopt extendedglob
setopt autocd

# export TERM=xterm-256color
export SAL_USE_VCLPLUGIN=gtk


# zsh syntax-highlighting
if [[ -r ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.dotfiles/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh autosuggestions
if [[ -r ~/.dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.dotfiles/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

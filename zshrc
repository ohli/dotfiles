autoload -Uz compinit promptinit
compinit
promptinit

export TERM=xterm-256color
export SAL_USE_VCLPLUGIN=gtk

alias ls='ls -Fs --color=auto'
alias ll='ls -Fsl --color=auto'
alias la='ls -Fsla --color=auto'

# powerline
source ~/.local/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

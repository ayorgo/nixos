#!/bin/bash

# FZF config
export FZF_DEFAULT_OPTS='--height 40% --border --color=gutter:-1'
export FZF_DEFAULT_COMMAND='find'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_eternal_history
export HISTCONTROL=ignoreboth:erasedups           # no duplicate entries

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ "$HOSTNAME" != "tuxedo" ]; then
  PS1="\n╭─\[$(tput bold)\]\[\033[38;5;166m\]\u\[$(tput sgr0)\]@\[$(tput bold)\]\[\033[38;5;85m\]\h\[$(tput sgr0)\]\[$(tput bold)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\] \n╰─\[$(tput bold)\]\[\033[38;5;197m\]❯❯❯\[$(tput sgr0)\] "
else
  PS1="\n╭─\[$(tput bold)\]\[\033[38;5;166m\]\u\[$(tput sgr0)\]\[$(tput bold)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\] \n╰─\[$(tput bold)\]\[\033[38;5;197m\]❯❯❯\[$(tput sgr0)\] "
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Point ssh to a running instance of ssh-agent
eval $(ssh-agent) > /dev/null 2>&1
ssh-add ~/.ssh/id_ed25519_ayorgo > /dev/null 2>&1

# Vim keybindings
set -o vi

# FZF keybindings
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

# Offload Steam to NVidia GPU
export XDG_DATA_HOME="$HOME/.local/share"

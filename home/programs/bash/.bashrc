#!/bin/bash

# FZF config
export FZF_DEFAULT_OPTS='--height 40% --border --gutter " "'
export FZF_DEFAULT_COMMAND='find'

# FZF keybindings
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

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

# Point ssh to a running instance of ssh-agent
eval $(ssh-agent) > /dev/null 2>&1
ssh-add ~/.ssh/id_ed25519_ayorgo > /dev/null 2>&1

# Offload Steam to NVidia GPU
export XDG_DATA_HOME="$HOME/.local/share"

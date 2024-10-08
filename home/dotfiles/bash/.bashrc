#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# FZF config
export FZF_DEFAULT_OPTS='--height 40% --border --color=gutter:-1'
export FZF_DEFAULT_COMMAND='find'

# Colors for bash
# export TERM="xterm-256color"                      # getting proper colors
# export HISTCONTROL=ignoredups:erasedups           # no duplicate entries
# export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# HISTCONTROL=ignoreboth

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color|*-256color) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# 	# We have color support; assume it's compliant with Ecma-48
# 	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# 	# a case would tend to support setf rather than setaf.)
# 	color_prompt=yes
#     else
# 	color_prompt=
#     fi
# fi

# PS1='[\t]\u:\w$ '

if [ "$HOSTNAME" != "tuxedo" ]; then
  PS1="\n╭─\[$(tput bold)\]\[\033[38;5;166m\]\u\[$(tput sgr0)\]@\[$(tput bold)\]\[\033[38;5;85m\]\h\[$(tput sgr0)\]\[$(tput bold)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\] \n╰─\[$(tput bold)\]\[\033[38;5;197m\]❯❯❯\[$(tput sgr0)\] "
else
  PS1="\n╭─\[$(tput bold)\]\[\033[38;5;166m\]\u\[$(tput sgr0)\]\[$(tput bold)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\] \n╰─\[$(tput bold)\]\[\033[38;5;197m\]❯❯❯\[$(tput sgr0)\] "
fi

# So Kitty displays a good title
PROMPT_COMMAND='echo -ne "\033]0;$(basename $(dirname ${PWD}))/$(basename ${PWD})\007"'

# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\d \t \a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# PATH="$HOME/.local/bin:$PATH"

if command -v cowsay > /dev/null && command -v fortune > /dev/null; then
    fortune | cowsay
fi

# Point ssh to a running instance of ssh-agent
eval $(ssh-agent) > /dev/null 2>&1
ssh-add ~/.ssh/id_ed25519_lyst > /dev/null 2>&1
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

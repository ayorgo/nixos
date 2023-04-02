#!/bin/bash

alias clone=/home/ayorgo/lyst/clone.sh

function task() { /usr/bin/task "$@" | less ; }

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lah'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Spotify scaling
alias spotify='spotify --force-device-scale-factor=1.25'

# Steam scaling
alias steam='GDK_SCALE=2 steam'

# Add some colors
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function free_port() {
    for port in $(seq $1 $2); do
        ss -atun | grep -q ":$port " || break
    done

    echo $port
}

function dockerize() {
    COMMAND=echo $@ | sed "s/jupyter notebook/jupyter notebook -y --ip 0.0.0.0 --no-browser/g"
    PORT=$(free_port 8880 8889)
    (
        set -x;
        docker run -it -p \
        $PORT:8888 \
        -v $(pwd):/home/ayorgo/code \
        -v ~/.aws:/home/ayorgo/.aws \
        -v ~/.aws/credentials:/home/ayorgo/.aws/credentials \
        -e DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --env IPYTHONDIR=/home/ayorgo/code/.ipython \
        --env HISTFILE=/home/ayorgo/code/.bash_history \
        $COMMAND
    ) | sed "s/8888/$PORT/g"
}

# Implies multiline pass output: username\npassword
function vpn() {
    VPN_CONFIG_FILE=~/client.ovpn
    VPN_CREDENTIALS="$(pass show work/openvpn)"
    sudo bash -c 'openvpn --config '"$VPN_CONFIG_FILE"' --auth-user-pass <(echo "'"$VPN_CREDENTIALS"'")'
}

# WiFi connection
function wifi_connect() {
    WIFI_SSID="$1"
    WIFI_PASSWORD="$(pass show wifi/$WIFI_SSID)"
    sudo nmcli dev wifi con $WIFI_SSID password $WIFI_PASSWORD
}

function wifi_show() {
    nmcli dev wifi
}

# Fonts
function fonts() {
    fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E 's/(^: |:)//g' | tr , \\n | sort | uniq
}

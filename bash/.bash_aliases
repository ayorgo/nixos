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

# Kitty image preview
alias icat="kitty +kitten icat"

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
    for port in $(seq "$1" "$2"); do
        ss -atun | grep -q ":$port " || break
    done

    echo "$port"
}

function dockerize() {
    PORT=$(free_port 8880 8889)
    COMMAND="$*"
    COMMAND="${COMMAND//jupyter notebook/jupyter notebook -y --ip 0.0.0.0 --port $PORT --no-browser}"
    COMMAND="${COMMAND//jupyter lab/jupyter lab -y --ip 0.0.0.0 --port $PORT --no-browser}"
    (
        touch /tmp/.bash_history;
        touch /tmp/history.sqlite;
        set -x;
        docker run --rm -it -p \
        "$PORT":"$PORT" \
        -v "$(pwd)":/home/ayorgo/code \
        -v /tmp/.bash_history:/home/ayorgo/.bash_history \
        -v /tmp/history.sqlite:/home/ayorgo/.ipython/profile_default/history.sqlite \
        -v ~/.aws:/home/ayorgo/.aws \
        -v ~/.aws/credentials:/home/ayorgo/.aws/credentials \
        -e DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        $COMMAND
    )
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

# Available GUI applications
function apps-gui() {

    # Find all the executable commands from available .desktop files
    # Filter out those compgen outputs that cannot be found among the above executables
    # Remove commands that contain special characters
    # Replace newline with pipe to conform to grep's multiple search criteria syntax
    # Sort in ascending order
    # Remove adjacent duplicates
    commands="$(
        find /usr/share/applications ~/.local/share/applications/ -name '*.desktop' \
        | xargs grep -sl 'Terminal=false' \
        | xargs grep -h '^Exec' \
        | awk -F '=' '{print $2}' \
        | grep -woEf <(compgen -c \
            | tr -dc '[:alnum:]-\n' \
            | tr '\n' '|') \
        | sort \
        | uniq \
    )"
    for command in $commands
    do
    type="$(type -t $command)"
    if [[ $type == "file" ]] || [[ $type == "alias" ]]; then
        echo $command
    fi
    done
}

function disk_usage() {
    depth="${1:-2}"
    du -ha -d "$depth" . 2>/dev/null | sort -hr | awk -F"/" "NF==$((depth+1))" | less
}

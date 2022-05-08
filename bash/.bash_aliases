alias clone=/home/ayorgo/lyst/clone.sh

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lh='ls -lah'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Add some colors
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

function dockerize() { docker run -it -p 8888:8888 -v $(pwd):/home/ayorgo/code -v ~/.aws:/ayorgo/home/.aws -v ~/.aws/credentials:/ayorgo/home/.aws/credentials -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --net=host "$@"; }

# Implies multiline pass output: username\npassword
function vpn() {
    VPN_CONFIG_FILE=~/client.ovpn
    VPN_CREDENTIALS="$(pass show work/openvpn)"
    sudo bash -c 'openvpn --config '"$VPN_CONFIG_FILE"' --auth-user-pass <(echo "'"$VPN_CREDENTIALS"'")'
}

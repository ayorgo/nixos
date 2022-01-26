function dockerize() { docker run -it -p 8888:8888 -v $(pwd):/home/ayorgo/code -v ~/.aws:/ayorgo/home/.aws -v ~/.aws/credentials:/ayorgo/home/.aws/credentials -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix "$@"; }

# Implies multiline pass output: username\npassword
function vpn() {
    VPN_CONFIG_FILE=~/client.ovpn
    VPN_CREDENTIALS="$(pass show work/openvpn)"
    sudo bash -c 'openvpn --config '"$VPN_CONFIG_FILE"' --auth-user-pass <(echo "'"$VPN_CREDENTIALS"'")'
}

function dockerize() { docker run -it -p 8888:8888 -v $(pwd):/home/ayorgo/code -v ~/.aws:/home/ayorgo/.aws -v ~/.aws/credentials:/home/ayorgo/.aws/credentials -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix "$@"; }

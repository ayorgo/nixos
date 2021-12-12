alias python=/usr/bin/python3.7
alias python3=/usr/bin/python3.7
alias pip=pip3
alias clone='~/source/clone.sh'
function dockerize() { docker run -it -P -v $(pwd):/home/ayorgo/code -v ~/.aws:/ayorgo/home/.aws -v ~/.aws/credentials:/ayorgo/home/.aws/credentials "$@"; }

# bash

alias {up,..}="cd .."

# busybox

alias cp="cp -i"
alias df="df -h"
alias du="du -h"
alias grep="grep --exclude-dir '.git' --color=tty"
alias free="free -m"
alias l="ls -lh --color"
alias ll="ls -lh --color"
alias lla="ll -a --color"
alias ls="ls --color"
alias mv="mv -i"

# docker

docker-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" "$1"
}

# history

history-clean() {
    > ~/.bash_history
    history -c
}

# ssh

alias ssh-unsafe="ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile /dev/null'"

# sudo

alias sudo="sudo "

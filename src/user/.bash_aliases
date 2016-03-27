# bash

alias {up,..}='cd ..'

# busybox

alias cp='cp -i'
alias df='df -h'
alias du='du -h'
alias grep='grep --exclude-dir ".git" --color=tty'
alias free='free -m'
alias l='ls -lh --color'
alias ll='ls -lh --color'
alias lla='ll -a --color'
alias ls='ls --color'
alias mv='mv -i'

# docker

docker-clean() {
    docker ps -qf status=exited | xargs docker rm > /dev/null 2>&1
    docker images -qf dangling=true | xargs docker rmi > /dev/null 2>&1
    docker volume ls -qf dangling=true | xargs -r docker volume rm > /dev/null 2>&1
}

docker-ip() {
    docker inspect --format "{{ .NetworkSettings.IPAddress }}" $1
}

docker-rename() {
    docker tag $1 $2 && docker rmi $1 > /dev/null 2>&1
}

docker-stop() {
    docker rm -f $(docker ps -q) > /dev/null 2>&1 || :
}

# php

alias php='php -dzend_extension=xdebug.so'

# history

alias history-clean='echo > $HOME/.bash_history ; history -c'

# ssh

alias ssh-unsafe='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'

# sudo

alias fuck='sudo $(history -p \!\!)'
alias sudo='sudo '

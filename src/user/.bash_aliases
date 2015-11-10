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

alias docker-clean='docker rm $(docker ps -q -f status=exited) 2> /dev/null ; docker rmi $(docker images -q -f "dangling=true") 2> /dev/null || :'
alias docker-ip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias docker-stop='docker kill $(docker ps -q) 2> /dev/null || :'

# ssh

alias ssh-unsafe='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'

# sudo

alias fuck='sudo $(history -p \!\!)'
alias sudo='sudo '

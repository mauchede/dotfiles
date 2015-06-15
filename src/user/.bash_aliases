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

alias docker-ip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'

# ssh

alias ssh-unsafe='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile /dev/null"'

# sudo

alias fuck='sudo $(history -p \!\!)'
alias sudo='sudo '

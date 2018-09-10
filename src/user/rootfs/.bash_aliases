# bash

alias {up,..}="cd .."

# busybox

alias cp="cp -i"
alias df="df -h"
alias du="du -h"
alias grep="grep --exclude-dir '.git' --color=tty"
alias ll="ls -lh"
alias lla="ll -a"
alias mv="mv -i"

# history

history-clean() {
    > "${HOME}"/.bash_history
    history -c
}

# ssh

alias ssh-unsafe="ssh -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile /dev/null'"

# sudo

alias sudo="sudo "

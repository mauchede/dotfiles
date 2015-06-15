# bash configuration

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

[[ -f /etc/bash_completion ]] && [[ ! $(shopt -oq posix) ]] && . /etc/bash_completion
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# git configuration

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1

# history configuration

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTIGNORE="ls:cd:[bf]g:exit:clear"
export HISTCONTROL="ignoreboth"

# prompt configuration

__get_terminal_column() {
    exec < /dev/tty
    local oldstty=$(stty -g)
    stty raw -echo min 0
    echo -en "\033[6n" > /dev/tty
    local pos
    IFS=';' read -r -d R -a pos
    stty $oldstty
    echo "$((${pos[1]} - 1))"
}

__set_prompt () {
    EXIT_CODE=$?
    BLUE='\[\e[01;34m\]'
    WHITE='\[\e[01;37m\]'
    RED='\[\e[01;31m\]'
    GREEN='\[\e[01;32m\]'
    YELLOW='\[\e[01;93m\]'
    PURPLE='\[\e[01;95m\]'
    RESET='\[\e[00m\]'
    FANCYX='\342\234\227'
    CHECKMARK='\342\234\223'

    PS1=""

    # new line if necessary

    [[ $(__get_terminal_column) != 0 ]] && PS1+="\n"

    # exit status

    PS1+="$WHITE\$? "
    if [[ $EXIT_CODE == 0 ]] ; then
        PS1+="$GREEN$CHECKMARK "
    else
        PS1+="$RED$FANCYX "
    fi

    # time

    PS1+="$RESET[\\t] "

    # user

    if [[ $EUID == 0 ]] ; then
        PS1+="$RED\\h "
    else
        PS1+="$GREEN\\u@\\h "
    fi

    # working directory

    PS1+="$BLUE\\w "

    # vcs

    if [[ -n $(__git_ps1) ]] ; then
        # yellow: branch is not up to date
        GIT_COLOR=$YELLOW

        # purple: no upstream configured for branch
        [[ ! $(git rev-parse @{u} 2> /dev/null) ]] && GIT_COLOR=$PURPLE

        # green: branch is up to date
        [[ $(git rev-parse @ 2> /dev/null) == $(git rev-parse @{u} 2> /dev/null) ]] && GIT_COLOR=$GREEN

        # red: changes not staged
        [[ -n $(git status -s) ]] && GIT_COLOR=$RED

        PS1+=$(__git_ps1 "$GIT_COLOR(%s) ")
    fi

    # command prompt

    PS1+="\n$RESET\\\$ "
}
PROMPT_COMMAND='__set_prompt'
trap 'echo -ne "\e[0m"' DEBUG

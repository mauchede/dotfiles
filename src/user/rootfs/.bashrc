# bash configuration

if [ -f "${HOME}"/.bash_aliases ]; then
    source "${HOME}"/.bash_aliases
fi
if [ -s "${HOME}"/.env ]; then
    export $(grep -v "^#" "${HOME}"/.env | xargs -0)
fi
if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
    source "$(brew --prefix)"/etc/bash_completion
fi
complete -cf sudo
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

# direnv configuration

eval "$(direnv hook bash)"

# git configuration

if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
    source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# history configuration

export HISTCONTROL="ignoreboth"
export HISTFILESIZE=10000
export HISTIGNORE="ls:cd:[bf]g:exit:clear"
export HISTSIZE=10000

# prompt configuration

__get_terminal_column() {
    exec < /dev/tty
    local oldstty
    oldstty="$(stty -g)"
    stty raw -echo min 0
    echo -en "\033[6n" > /dev/tty
    local pos
    IFS=";" read -r -d R -a pos
    stty "${oldstty}"
    echo "$((pos[1] - 1))"
}
__set_prompt() {
    EXIT_CODE="$?"
    BLUE="\[\e[01;34m\]"
    WHITE="\[\e[01;37m\]"
    RED="\[\e[01;31m\]"
    GREEN="\[\e[01;32m\]"
    YELLOW="\[\e[01;93m\]"
    PURPLE="\[\e[01;95m\]"
    RESET="\[\e[00m\]"
    FANCYX="\342\234\227"
    CHECKMARK="\342\234\223"

    PS1=""

    # new line if necessary

    if [ "$(__get_terminal_column)" != 0 ]; then
        PS1+="\n"
    fi

    # exit status

    PS1+="${WHITE}\$? "
    if [ "${EXIT_CODE}" == 0 ]; then
        PS1+="${GREEN}${CHECKMARK} "
    else
        PS1+="${RED}${FANCYX} "
    fi

    # time

    PS1+="${RESET}[\\t] "

    # user

    if [ "${EUID}" == 0 ]; then
        PS1+="${RED}\\u@\\h "
    else
        PS1+="${GREEN}\\u@\\h "
    fi

    # working directory

    PS1+="${BLUE}\\w "

    # vcs

    if [ "$(declare -Ff __git_ps1)" ] && [ -n "$(__git_ps1)" ]; then
        # yellow: branch is not up to date
        GIT_COLOR="${YELLOW}"

        # purple: no upstream configured for branch
        if [ ! "$(git rev-parse "@{u}" 2> /dev/null)" ]; then
            GIT_COLOR="${PURPLE}"
        fi

        # green: branch is up to date
        if [ "$(git rev-parse @ 2> /dev/null)" == "$(git rev-parse "@{u}" 2> /dev/null)" ]; then
            GIT_COLOR="${GREEN}"
        fi

        # red: changes not staged
        if [ -n "$(git status -s)" ]; then
            GIT_COLOR="${RED}"
        fi

        PS1+="$(__git_ps1 "${GIT_COLOR}(%s) ")"
    fi

    # command prompt

    PS1+="\n${RESET}\\\$ "
}
PROMPT_COMMAND="${PROMPT_COMMAND};__set_prompt"

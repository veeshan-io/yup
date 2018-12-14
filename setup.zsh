#!/usr/bin/env zsh
setopt EXTENDED_GLOB
setopt NO_NOMATCH

# Run "setup.sh -f" to force re setup Yup.
main() {
    while {getopts f arg} {
        case $arg {
            (f)
            local force=1
            ;;
        }
    }
    shift $((OPTIND - 1))

    if { which tput >/dev/null 2>&1 } {
        ncolors=$(tput colors)
    }

    if [[ -t 1 && -n "$ncolors" && "$ncolors" -ge 8 ]] {
        YELLOW="$(tput setaf 3)"
        NORMAL="$(tput sgr0)"
    } else {
        YELLOW=""
        NORMAL=""
    }

    if { ! command -v zsh >/dev/null 2>&1 } { # equals: ! which zsh >/dev/null 2>&1
        echo "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!"
        exit
    }

    if [[ ! -f "~/.zshrc" ]] {
        touch ~/.zshrc
    }

    if [[ ! -n "$YHOME" ]] {
        YHOME=~/.yup
    }

    if [[ -d "$YHOME" ]] {
        if [[ $force ]] {
            echo "${YELLOW}Remove previous installed Yup.${NORMAL}"
            rm -rf ~/.yup
        } else {
            echo "${YELLOW}You already have Yup installed.${NORMAL}"
            echo 'Run "up-yup" for new version.'
            exit
        }
    }

    command -v git >/dev/null 2>&1 || {
        echo "Error: git is not installed."
        exit
    }

    git clone https://github.com/veeshan-io/yup.git $YHOME
    git -C $YHOME/.addons clone https://github.com/veeshan-io/ylib.git
    source $YHOME/yup.zsh
    yup update -i

    local -A vars
    vars=(
        yhome
        $YHOME
    )
    file.write ~/.yuprc "$(view.render $YHOME/.yuprc-example ${(kv)vars})"

    if [[ $(file.include ~/.zshrc '.yuprc') == 'no' ]] {
        echo '>> Raise yup in zshrc'
        # local insert=(
        #     "\n"
        #     '# Raise yup stack.'
        #     'source ~/.yuprc'
        #     "\n"
        # )

        file.backup ~/.zshrc
        sed -i 's#source $ZSH/oh-my-zsh.sh#\n\# Raise yup stack.\nsource ~/.yuprc\n\nsource $ZSH/oh-my-zsh.sh#' ~/.zshrc

        # file.write ~/.zshrc "$(file.insert_before ~/.zshrc ZSH/oh-my-zsh.sh $insert)"
    }

    env zsh -l
}

main $*

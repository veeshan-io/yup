#!/usr/bin/env zsh
# 初始化及安装
# 编译补全代码
setopt EXTENDED_GLOB
setopt NO_NOMATCH
main() { # line +4
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

    getopts f arg
    if [[ $arg ]] {
        local force=1
    }
    if [[ -d "$YHOME" ]] {
        if [[ $force ]] {
            echo "${YELLOW}Remove previous installed Yup.${NORMAL}"
            rm -rf ~/.yup
        } else {
            echo "${YELLOW}You already have Yup installed.${NORMAL}"
            echo "Run `yup upgrade` for new version."
            exit
        }
    }

    command -v git >/dev/null 2>&1 || {
        echo "Error: git is not installed."
        exit 1
    }

    git clone https://github.com/veeshan-io/yup.git $YHOME
    source $YHOME/yup.zsh
    yup update

    # 生成.yuprc 并 env zsh -l 重启
}

main $*


# git clone https://github.com/LXTechnic/vagbook-cli.git ~/.vagbook-cli
# chmod 755 ~/.vagbook-cli/bin/*
# if [[ -f $HOME/.zshrc ]];then
#     echo "source $HOME/.vagbook-cli/load.sh" |tee -a $HOME/.zshrc
#     echo "export VAGBOOK_MASTER=$master" |tee -a $HOME/.zshrc
# else
#     echo "source $HOME/.vagbook-cli/load.sh" |tee -a $HOME/.bashrc
#     echo "export VAGBOOK_MASTER=$master" |tee -a $HOME/.bashrc
# fi
# source $HOME/.vagbook-cli/load.sh
# export VAGBOOK_MASTER=$master
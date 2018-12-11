#!/usr/bin/env zsh
setopt NO_NOMATCH

export YHOME=$(cd `dirname $0`; pwd)

# 载入libs

yup() {
    local cmd=$1

    for lib ($YHOME/.libs/**/src/*(.)) {
        [[ -f $lib ]] && source $lib
    }

    # core call
    local core_cmd=$YHOME/core/${cmd}.zsh
    if [[ -f $core_cmd ]] {
        source $core_cmd
        main $*[2,-1]
        exit
    }

    for call ($YHOME/.plugs/**/cmd/${cmd}.zsh) {
        [[ -f $call ]] && source ${call}
        main $*[2,-1]
        break
    }
}


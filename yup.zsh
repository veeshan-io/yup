#!/usr/bin/env zsh
setopt NO_NOMATCH

export YHOME=$(cd `dirname $0`; pwd)

yup() {
    local cmd=$1

    # lib src
    for src_file ($YHOME/src/*.zsh) {
        [[ -f $src_file ]] && source $src_file
    }
    for src_file ($YHOME/.addons/**/src/*(.)) {
        [[ -f $src_file ]] && source $src_file
    }

    # core call
    local cmd_file=$YHOME/cmd/${cmd}.zsh
    if [[ -f $cmd_file ]] {
        source $cmd_file
        $cmd $*[2,-1]
        return
    }

    for cmd_file ($YHOME/.addons/**/cmd/${cmd}.zsh) {
        [[ -f $cmd_file ]] && source ${cmd_file}
        $cmd $*[2,-1]
        break
    }
}


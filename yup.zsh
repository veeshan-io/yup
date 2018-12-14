#!/usr/bin/env zsh
setopt NO_NOMATCH

export YHOME=$(cd `dirname $0`; pwd)

yup() {
    setopt RM_STAR_SILENT

    local cmd=$1

    for lib_file ($YHOME/lib/*.zsh) {
        [[ -f $lib_file ]] && source $lib_file
    }
    for lib_file ($YHOME/.addons/**/lib/*(.)) {
        [[ -f $lib_file ]] && source $lib_file
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


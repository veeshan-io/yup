#!/usr/bin/env zsh
if [[ ! -n "$YHOME" ]] {
    local YHOME=$(cd `dirname $0`/..; pwd)
}
main() { # line +4
    echo ">> Update yup.."
    git.renew $YHOME
    git.renew $YHOME/.addons/ylib

    # 执行更新
    yup update
}

main $*

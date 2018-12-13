#!/usr/bin/env zsh
if [[ ! -n "$YHOME" ]] {
    local YHOME=$(cd `dirname $0`/..; pwd)
}
main() {
    echo ">> Update yup.."
    br=`git -C $YHOME branch | grep '*'`;
    br=${br/* /}
    git -C $YHOME fetch --all
    git -C $YHOME reset --hard origin/${br}

    br=`git -C $YHOME/.addons/ylib branch | grep '*'`;
    br=${br/* /}
    git -C $YHOME/.addons/ylib fetch --all
    git -C $YHOME/.addons/ylib reset --hard origin/${br}

    # 执行更新
    yup update
}

main $*

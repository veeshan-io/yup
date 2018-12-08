#!/usr/bin/env zsh
if [[ ! -n "$YHOME" ]] {
    YHOME=$(cd `dirname $0`/..; pwd)
}
main() { # line +2
    git -C $YHOME pull
    git -C $YHOME/.libs pull

    # 上面的两个任务是yup-up的工作，确保能安全自举和更新
    # 构建 yuprc 放入.zshrc中 并执行一次
    # 执行yup update，下载plug 包括扫描各个plug的bin目录 复制文件进.bin
    # .autoload生成 包括: 各plug的init.zsh libs的pub部分 运行一遍，并放进yuprc中

    # cmd采用实时扫描 core则是写死
    # .libs目录下的文件也是实时扫描不预生成
}

main $*

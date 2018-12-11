setopt NO_NOMATCH
main() { # line +4
    up_libs() {
        local -A checked

        # update & checkout
        for git_url ($*) {
            local dir=$YHOME/.libs/$(git.dir $git_url)
            if [[ -d $dir ]] {
                git.renew $dir
            }
            if [[ ! -e $dir ]] {
                git -C $YHOME/.libs clone $git_url
            }
            checked[$dir]=1
        }

        # remove
        for dir ($YHOME/.libs/*(/)) {
            if [[ -d $dir && ! $checked[$dir] ]] {
                rm -rf $dir
                echo "- Removed lib: $dir"
            }
        }
    }

    up_plugs() {
        local -A checked

        # update & checkout
        for git_url ($*) {
            local dir=$YHOME/.plugs/$(git.dir $git_url)
            if [[ -d $dir ]] {
                git.renew $dir
            }
            if [[ ! -e $dir ]] {
                git -C $YHOME/.plugs clone $git_url
            }
            checked[$dir]=1
        }

        # remove
        for dir ($YHOME/.plugs/*(/)) {
            if [[ -d $dir && ! $checked[$dir] ]] {
                rm -rf $dir
                echo "- Removed plug: $dir"
            }
        }
    }

    rebuild_bin() {
        rm -f $YHOME/.bin/*
        for bin ($YHOME/.plugs/**/bin/*.zsh) {
            if [[ ! -e $bin ]] {
                continue
            }
            chmod +x $bin
            ln -s $bin $YHOME/.bin/${${bin##*/}%.*}
        }
        for bin ($YHOME/bin/*.zsh) {
            if [[ ! -e $bin ]] {
                continue
            }
            chmod +x $bin
            ln -s $bin $YHOME/.bin/${${bin##*/}%.*}
        }
    }

    rebuild_autoload() {
        >$YHOME/.autoload < /dev/null
        for pub ($YHOME/.libs/**/pub/*.zsh) {
            if [[ ! -e $pub ]] {
                continue
            }
            echo "source $pub" >> $YHOME/.autoload
        }
        for pub ($YHOME/.plugs/**/init.zsh) {
            if [[ ! -e $pub ]] {
                continue
            }
            echo "source $pub" >> $YHOME/.autoload
        }
    }

    getopts i arg
    if [[ $arg ]] {
        local init=1
    }

    if [[ ! $_libs ]] {
        _libs=()
    }
    _libs+='https://github.com/veeshan-io/ylib.git'
    echo ">> Update Libs"
    up_libs $_libs
    # up_libs ${_libs[*]} 传递数组作为第一个参数模式
    echo ""

    if [[ ! $_plugs ]] {
        _plugs=()
    }
    echo ">> Update Plugs"
    up_plugs $_plugs
    echo ""

    echo ">> Rebuild Bin Files"
    rebuild_bin
    echo ""

    echo ">> Rebuild Autoload"
    rebuild_autoload
    echo ""

    # 重启
    if [[ ! $init ]] {
        env zsh -l
    }
}

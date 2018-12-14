setopt NO_NOMATCH
update() {
    while {getopts c:i arg} {
        case $arg {
            (i)
            local init=1
            ;;
            (c)
            local config=$OPTARG
            ;;
        }
    }
    shift $((OPTIND - 1))

    make_yuprc() {
        local -A vars
        vars=(
            yhome
            $YHOME
        )
        "$(curl -fsSL $1)"
        file.write ~/.yuprc "$(view.render $YHOME/.yuprc-example ${(kv)vars})"
    }

    up_addons() {
        local -A checked

        # update & checkout
        for git_url ($*) {
            local dir=$YHOME/.addons/$(git.dir $git_url)
            if [[ -d $dir ]] {
                git.renew $dir
            }
            if [[ ! -e $dir ]] {
                git -C $YHOME/.addons clone $git_url
            }
            checked[$dir]=1
        }

        # remove
        for dir ($YHOME/.addons/*(/)) {
            if [[ -d $dir && ! $checked[$dir] ]] {
                rm -rf $dir
                echo "- Removed addon: $dir"
            }
        }
    }

    rebuild_bin() {
        rm -f $YHOME/.bin/*
        for bin ($YHOME/bin/*.zsh) {
            if [[ ! -e $bin ]] {
                continue
            }
            chmod +x $bin
            ln -s $bin $YHOME/.bin/${${bin##*/}%.*}
        }
        for bin ($YHOME/.addons/**/bin/*.zsh) {
            if [[ ! -e $bin ]] {
                continue
            }
            chmod +x $bin
            ln -s $bin $YHOME/.bin/${${bin##*/}%.*}
        }
    }

    rebuild_autoload() {
        >$YHOME/.autoload < /dev/null
        for pub ($YHOME/.addons/**/pub/*.zsh) {
            if [[ ! -e $pub ]] {
                continue
            }
            echo "source $pub" >> $YHOME/.autoload
        }
        for pub ($YHOME/.addons/**/init.zsh) {
            if [[ ! -e $pub ]] {
                continue
            }
            echo "source $pub" >> $YHOME/.autoload
        }
    }

    if [[ ! $_addons ]] {
        _addons=()
    }
    _addons+='https://github.com/veeshan-io/ylib.git'
    echo ">> Update Addons"
    up_addons $_addons
    # up_addons ${_addons[*]} 传递数组作为第一个参数模式
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

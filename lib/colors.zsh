if { which tput >/dev/null 2>&1 } {
    ncolors=$(tput colors)
}

if [[ -t 1 && -n "$ncolors" && "$ncolors" -ge 8 ]] {
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
} else {
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
}
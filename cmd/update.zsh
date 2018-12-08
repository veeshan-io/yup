#!/usr/bin/env zsh

local files=("${(f)$(md5sum **/*(.D))}")
local files_to_delete=()
local -A md5s

for i ($files) {
    local md5=$i[1,32]

    if (($+md5s[$md5])) {
        files_to_delete+=($i[35,-1])
    } else {
        md5s[$md5]=1
    }
}

(($#files_to_delete)) && rm -v $files_to_delete

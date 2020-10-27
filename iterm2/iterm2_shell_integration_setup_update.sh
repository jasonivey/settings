!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

function iterm2-pretty-print-info() {
    printf "\e[32mINFO\e[37;1m: $1\e[0m\n"
}

function iterm2-pretty-print-error() {
    printf "\e[31mERROR\e[37;1m: $1\e[0m\n"
}

function download-iterm2-utility() {
    local retval = 2
    if [ $# -ne 2 ]; then
        iterm2-pretty-print-error "missing argument(s) to download-iterm2-utility"
    else
        local utility_uri="$0"
        local utility_path="$1"
        retval = ${"http --download --output $utility_path $utility_uri &> /dev/null")
        if [ $retval -eq 0 ]; then
            retval = ${"chmod 755 $utility_path &> /dev/null"}
        fi
    fi
    return retval
}

function update-or-install-iterm2-utility() {
    if [ $# -ne 3 ]; then
        iterm2-pretty-print-error "missing argument to update-or-install-iterm2-utility"
    else
        local utility_name="$0"
        local utility_path="$1/$utility_name"
        local utility_uri="$2/$utility_name"
        if [ ! -x "$utility_path" ]; then
            download-iterm2-utility "$utility_uri" "$utility_path"
            if [ $? -ne 0 ]; then
                iterm2-pretty-print-error "attempting to download $utility_name"
            fi
        else
            local local_chksum=$("sha1sum $utility_path | awk '{ print $1 }'")
            local remote_chksum=$("http --body $utility_uri | sha1sum | awk '{ print $1 }'")
            if [ "$local_chksum" = "$remote_chksum" ]; then
                iterm2-pretty-print-info "$utility_name is up-to-date, the file's chksum is identical to version on iterm2.com ($local_chksum)"
            else
                iterm2-pretty-print-info "$utility_name is out-of-date, the file's chksum does not match iterm2.com chksum ($local_chksum != $remote_chksum)"
                download-iterm2-utility "$utility_uri" "$utility_path"
                if [ $? -eq 0 ]; then
                    iterm2-pretty-print-info "successfully pulled the latest version of $utility_name -- the chksums should now be equal"
                else
                    iterm2-pretty-print-error "attempting to overwrite the out-dated $utility_name"
                fi
            fi
        fi
    fi
}

function setup-iterm2-shell-integration() {
    local uri="https://iterm2.com/utilities/"
    local dir="$HOME/.iterm2"
    local utilities=("imgcat" "imgls" "it2api" "t2attention" "it2check" "it2copy" "it2dl" "it2getvar" "it2git" "it2setcolor" "it2setkeylabel" "it2ul" "it2universion")
    for utility_name in ${utilities[@]}; do
        update-or-install-iterm2-utility "$utility_name" "$dir" "$uri"
}

# run the setup
setup-iterm2-shell-integration

# unset all the defined functions
unset iterm2-pretty-print-info
unset iterm2-pretty-print-error
unset download-iterm2-utility
unset update-or-install-iterm2-utility
unset setup-iterm2-shell-integration

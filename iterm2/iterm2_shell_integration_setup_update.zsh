#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

function iterm2-pretty-print-info() {
    printf "\e[32mINFO\e[37;1m: $1\e[0m\n"
}

function iterm2-pretty-print-error() {
    printf "\e[31mERROR\e[37;1m: $1\e[0m\n"
}

function download-iterm2-utility() {
    if [ $# -ne 2 ]; then
        iterm2-pretty-print-error "missing argument(s) to download-iterm2-utility"
    else
        local utility_uri="$1"
        local utility_path="$2"
        iterm2-pretty-print-info "downloading $utility_uri to $utility_path"
        http --download --output $utility_path $utility_uri &>/dev/null
        if [[ $? == 0 ]] then
            chmod 755 $utility_path &>/dev/null
            if [[ $? == 0 ]] then
                iterm2-pretty-print-info "successfully downloaded $utility_path and chmod +x"
            else
                iterm2-pretty-print-error "when trying to chmod +x on $utility_path"
            fi
        else
            iterm2-pretty-print-error "when using httpie to download $utility_uri"
        fi
    fi
}

function update-or-install-iterm2-utility() {
    if [ $# -ne 3 ]; then
        iterm2-pretty-print-error "missing argument to update-or-install-iterm2-utility"
    else
        local utility_name="$1"
        local utility_path="$2/$utility_name"
        local utility_uri="$3/$utility_name"
        iterm2-pretty-print-info "name: $utility_name"
        iterm2-pretty-print-info "path: $utility_path"
        iterm2-pretty-print-info "uri: $utility_uri"
        if [[ ! -x "$utility_path" ]] then
            download-iterm2-utility "$utility_uri" "$utility_path"
        else
            local local_chksum=$("sha1sum $utility_path | awk '{ print \$1 }'")
            local remote_chksum=$("http --body $utility_uri | sha1sum | awk '{ print \$1 }'")
            if [ "$local_chksum"  = "$remote_chksum" ]; then
                iterm2-pretty-print-info "$utility_name is up-to-date, the sha1sum of the file match the sha1sum of the file on iterm2.com ($local_chksum)"
            else
                iterm2-pretty-print-info "$utility_name is out-of-date, the sha1sum of the file does not match the sha1sum of the file on iterm2.com ($local_chksum != $remote_chksum)"
                download-iterm2-utility "$utility_uri" "$utility_path"
            fi
        fi
    fi
}

function setup-iterm2-shell-integration() {
    local iterm2_uri="https://iterm2.com/utilities"
    local iterm2_dir="$HOME/settings/iterm2/.iterm2"
    local utilities=("imgcat" "imgls" "it2api" "it2attention" "it2check" "it2copy" "it2dl" "it2getvar" "it2git" "it2setcolor" "it2setkeylabel" "it2ul" "it2universion")
    for utility_name in ${utilities[@]}; do
        update-or-install-iterm2-utility "$utility_name" "$iterm2_dir" "$iterm2_uri"
    done
}

# run the setup
setup-iterm2-shell-integration

# unset all the defined functions
unfunction iterm2-pretty-print-info
unfunction iterm2-pretty-print-error
unfunction download-iterm2-utility
unfunction update-or-install-iterm2-utility
unfunction setup-iterm2-shell-integration

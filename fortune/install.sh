#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

set -e

clean_up() {
    unset echo_title
    unset echo_error_msg
    unset echo_info_msg
    unset install_fortunes_macos
    unset install_fortunes_linux
}
trap clean_up EXIT

echo_title() {
    echo -e "\e[36m$1\e[0m"
}

echo_error_msg() {
    echo -e "\e[31mERROR\e[0m\e[1m: $1\e[0m"
    exit
}

echo_info_msg() {
    echo -e "\e[32mINFO\e[0m\e[1m: $1\e[0m"
}

install_fortunes_macos() {
    local src_dir=$1
    local dest_dir="/usr/local/Cellar/fortune/9708/share/games/fortunes"
    if [[ -d "$dest_dir" ]]; then
        sudo mv -f "$src_dir/softwareengineering.dat" "$dest_dir/softwareengineering.dat"
        echo_info_msg "moved softwareengineering.dat into $dest_dir"
        sudo mv -f "$src_dir/softwareengineering" "$dest_dir/softwareengineering"
        echo_info_msg "moved softwareengineering into $dest_dir"
    else
        echo_error_msg "fortune directory $dest_dir does not exist"
    fi
}

install_fortunes_linux() {
    local src_dir=$1
    local dest_dir="/usr/share/games/fortunes"
    if [[ -d "$dest_dir" ]]; then
        sudo mv -f "$src_dir/softwareengineering.dat" "$dest_dir/softwareengineering.dat"
        echo_info_msg "moved softwareengineering.dat into $dest_dir"
        sudo mv -f "$src_dir/softwareengineering" "$dest_dir/softwareengineering"
        echo_info_msg "moved softwareengineering into $dest_dir"
        sudo chmod 644 "$dest_dir/softwareengineering" "$dest_dir/softwareengineering.dat"
        echo_info_msg "updated permissions of softwareengineering and softwareengineering.dat"
        sudo chown root:root "$dest_dir/softwareengineering" "$dest_dir/softwareengineering.dat"
        echo_info_msg "changed ownership of softwareengineering and softwareengineering.dat"
        sudo ln -s -r -f "$dest_dir/softwareengineering" "$dest_dir/softwareengineering.u8"
        echo_info_msg "created symbolic link of softwareengineering softwareengineering.u8"
    else
        echo_error_msg "fortune directory $dest_dir does not exist"
    fi
}

echo_title "softwareengineering fortune installation..."

if [[ -x "$(command -v fortune)" && -x "$(command -v strfile)" ]]; then
    src_dir='/tmp'
    cp -f $HOME/settings/fortune/softwareengineering.txt $src_dir/softwareengineering
    echo_info_msg "created copy of softwareengineering.txt in $src_dir/softwareengineering"
    strfile $src_dir/softwareengineering $src_dir/softwareengineering.dat &>/dev/null
    echo_info_msg "created $src_dir/softwareengineering.dat using strfile and $src_dir/softwareengineering"
    if [[ "$(uname)" == "Darwin" ]]; then
        install_fortunes_macos $src_dir
    elif [[ "$(uname -s)" == "Linux" ]]; then
        install_fortunes_linux $src_dir
    fi
    unset src_dir
else
    echo_error_msg "fortune or strfile is not installed"
fi

echo_title "installation of softwareengineering fortunes successful..."
echo_title "  ...test using 'watch -tc -n 2 fortune softwareengineering'"

#watch fortune softwareengineering

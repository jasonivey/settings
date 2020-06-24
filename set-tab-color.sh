#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

#https://unix.stackexchange.com/questions/59360/what-is-the-zsh-equivalent-of-bashs-export-f

set-tab-color() {
    if [ -e "$HOME/.zsh_color" ]; then
        echo $(head -n 1 $HOME/.zsh_color) | python3 $HOME/scripts/set_tab_color.py
    elif [ -e "$HOME/.bash_color" ]; then
        echo $(head -n 1 $HOME/.bash_color) | python3 $HOME/scripts/set_tab_color.py
    fi
}

set-tab-color

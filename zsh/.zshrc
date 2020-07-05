#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

# Set the DEFAULT_USER environment variable
[ -e "$HOME/.zsh_default_user" ] && source "$HOME/.zsh_default_user"

# If you come from bash you might have to change your $PATH.
[ -e "$HOME/.zsh_envs" ] && source "$HOME/.zsh_envs"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    autojump # install in mac/linux
    brew
    chucknorris  # fortune/cowsay
    command-not-found # install in linux
    debian # apt
    dircycle
    encode64 # base64
    extract
    git
    git-extras
    httpie # adds httpie completions
    rand-quote
    screen
    sudo
    tldr
    urltools
    z
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
[ -e "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"


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
    brew
    command-not-found # install in linux
    dircycle
    extract
    git
    git-extras
    httpie # adds httpie completions
    sudo
    tldr
    z
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# start by sourcing the needed zsh functions
[ -e "$HOME/.zsh_functions" ] && source "$HOME/.zsh_functions"

# User configuration
[ -e "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# lastly, source the zsh_sources which contains 3rd party module includes
[ -e "$HOME/.zsh_sources" ] && source "$HOME/.zsh_sources"

# set the iterm tab color if a color is specified using .zsh-color
set-tab-color

# if HUSH_LOGIN_INFO is not defined then print the custom LOGIN INFO
[ -z ${HUSH_LOGIN_INFO+x} ] && get-login-info

# if the .zshrc is ran more than once the PATH variable will have duplicates
#  along with a number of other variables. this function remidies that situation
de-duplicate-zsh-paths

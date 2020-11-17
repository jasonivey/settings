#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

# Set the DEFAULT_USER environment variable
[ -e "$HOME/settings/zsh/default_user.zsh" ] && source "$HOME/settings/zsh/default_user.zsh"

# If you come from bash you might have to change your $PATH.
[ -e "$HOME/settings/zsh/envs.zsh" ] && source "$HOME/settings/zsh/envs.zsh"

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

# retreive the stored secrets and storing them in the environment
[ -e "$HOME/settings/secrets/retrieve_secrets.sh" ] && source "$HOME/settings/secrets/retrieve_secrets.sh"

# start by sourcing the needed zsh functions
[ -e "$HOME/settings/zsh/functions.zsh" ] && source "$HOME/settings/zsh/functions.zsh"

# User configuration
[ -e "$HOME/settings/zsh/aliases.zsh" ] && source "$HOME/settings/zsh/aliases.zsh"

# lastly, source the zsh_sources which contains 3rd party module includes
[ -e "$HOME/settings/zsh/sources.zsh" ] && source "$HOME/settings/zsh/sources.zsh"

# set the iterm tab color if a color is specified using .zsh-color
set-tab-color

# if HUSH_LOGIN_INFO is not defined then print the custom LOGIN INFO
[ -z ${HUSH_LOGIN_INFO+x} ] && get-login-info

# if the .zshrc is ran more than once the PATH variable will have duplicates
#  along with a number of other variables. this function remidies that situation
de-duplicate-zsh-paths

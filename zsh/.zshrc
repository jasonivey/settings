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
    command-not-found        # install in linux
    dircycle
    extract                  # install all number of aliases for compressing and decompressing zip/tar/7z/etc.
    git
    git-extras
    httpie                   # adds httpie completions
    sudo
    tldr                     # install tldr (too-long-didn't-read) help pages, see note #1 below
    z                        # fast directory jumping
    zsh-autosuggestions      # git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    zsh-syntax-highlighting  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    zsh-vi-mode              # git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode
)

#
# note #1: tldr installation instructions ($ZSH_CUSTOM should be defined as $HOME/.oh-my-zsh/custom)
# npm install -g tldr
# mkdir -p $ZSH_CUSTOM/plugins/tldr
# ln -sr "$(dirname $(readlink -f $(which tldr)))/completion/zsh/_tldr" _tldr
#
# result: this will create a symbolic <relative> link to the zsh completions file
#

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


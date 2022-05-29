#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh
#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fig pre block. Keep at the top of this file.
source "$HOME/.fig/shell/zshrc.pre.zsh"

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
    z                        # fast directory jumping
    zsh-autosuggestions      # git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    zsh-vi-mode              # git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.oh-my-zsh/custom/plugins/zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# zsh-vi-mode requires: remap the backspace key to delete the previous character
bindkey "^?" backward-delete-char

# retreive the stored secrets and storing them in the environment
[ -e "$HOME/settings/secrets/export_secrets.sh" ] && source "$HOME/settings/secrets/export_secrets.sh"

# source the needed zsh functions
[ -e "$HOME/settings/zsh/functions.zsh" ] && source "$HOME/settings/zsh/functions.zsh"

# source the user configuration and aliases
[ -e "$HOME/settings/zsh/aliases.zsh" ] && source "$HOME/settings/zsh/aliases.zsh"

# set the iterm tab color if a color is specified using .zsh-color
set-tab-color

# if HUSH_LOGIN_INFO is not defined then print the custom LOGIN INFO
[ -e "$HOME/.hushlogin" ] || get-login-info

# lastly, source the zsh_sources which contains 3rd party module includes
[ -e "$HOME/settings/zsh/sources.zsh" ] && source "$HOME/settings/zsh/sources.zsh"

# if the .zshrc is ran more than once the PATH variable will have duplicates
#  along with a number of other variables. this function remidies that situation
de-duplicate-zsh-paths

# start starship cross-shell prompt
# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
source "$HOME/.fig/shell/zshrc.post.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#zprof

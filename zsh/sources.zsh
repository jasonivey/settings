#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

###
# Source various other zsh/bash modules
###

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh

# load the rust environment
[ -e "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# setup autocompletion for iTermocil
if [[ $(command -v itermocil &> /dev/null) ]] then
    compctl -g '~/.itermocil/*(:t:r)' itermocil
fi

# load the nix package installer and its bin to the path
#if [[ -d "/nix" ]] then
if [[ -d "/nix" && -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] then
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && source $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# setup command-not-found
if [[ "$(uname)" == "Darwin" ]] then
    HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
    if [ -f "$HB_CNF_HANDLER" ]; then
        source "$HB_CNF_HANDLER";
    fi
fi

# load the perlbrew perl package manager
[ -e "$PERLBREW_ROOT/etc/bashrc" ] && source "$PERLBREW_ROOT/etc/bashrc"

# load nvm npm package manager
if [[ -d "$HOME/.nvm" && -e "$HOME/.nvm/nvm.sh" ]] then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
fi

# Setup ruby environment, this will probably break vim & mvim
if [[ -d "/usr/local/opt/openssl" ]] then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl"
fi
command -v rbenv &>/dev/null && { eval "$(rbenv init -)"; }

if [ -e "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# If its available install the iterm2 shell integrations
[ -e "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"

# load the configuration for fzf
[ -f "${HOME}/.config/fzf/fzf.zsh" ] && source "${HOME}/.config/fzf/fzf.zsh"


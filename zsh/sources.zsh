#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

###
# Source various other zsh/bash modules
###

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
[ -r "$HOME/.opam/opam-init/init.zsh" ] && source "$HOME/.opam/opam-init/init.zsh" &> /dev/null || true

# setup command-not-found
if [[ "$(uname)" == "Darwin" ]] then
    HB_CNF_HANDLER="/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
    [ -f "$HB_CNF_HANDLER" ] && source "$HB_CNF_HANDLER"
    unset HB_CNF_HANDLER
fi

# load the perlbrew perl package manager
[ -e "$HOME/perl5/perlbrew/etc/bashrc" ] && source "$HOME/perl5/perlbrew/etc/bashrc"

# load nvm npm package manager
if [[ -d "$HOME/.nvm" && -e "$HOME/.nvm/nvm.sh" ]] then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
fi

# Setup ruby environment, this will probably break vim & mvim
if [[ -d "/usr/local/opt/openssl@1.1" ]] then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
fi
command -v rbenv &>/dev/null && { eval "$(rbenv init -)"; }

# Setup pyenv environment
command -v pyenv &>/dev/null && { eval "$(pyenv init -)"; }

# Setup the pyenv-virtualenv environment
command -v pyenv-virtualenv-init &>/dev/null && { eval "$(pyenv virtualenv-init -)"; }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# If its available install the iterm2 shell integrations
[ -e "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"

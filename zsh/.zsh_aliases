#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

###
# Aliases for zsh
###

# Aliases to open configure files
alias zshrc='$EDITOR $HOME/.zshrc'
alias ohmyzsh='$EDITOR $HOME/.oh-my-zsh'
alias settings='$EDITOR $HOME/settings/.bash_settings'
alias zsettings='$EDITOR $HOME/settings/.zshrc'
alias setting-dir='cd $HOME/settings'

# standard commands made more dummy proof
if [[ "$(uname)" == "Darwin" && $(command -v trash) ]] then
    alias rm='trash -v'
else
    alias rm='rm --verbose --interactive=once --preserve-root=all'
fi
alias mv='mv --verbose --interactive'
alias cp='cp --verbose --interactive'
alias ln='ln --verbose --interactive --relative'
alias chown='chown --verbose --preserve-root'
alias chmod='chmod --verbose --preserve-root'
alias chgrp='chgrp --verbose --preserve-root'

# Stow app aliases because they are impossible to remember
alias install-links-simulate='stow --simulate --stow'
alias install-links='stow --stow'
alias reinstall-links-simulate='stow --simulate --restow'
alias reinstall-links='stow --restow'
alias uninstall-links-simulate='stow --simulate --delete'
alias uninstall-links='stow --delete'

local stowable_packages="config gdb git vim zsh"
alias install-all-links-simulate="install-links-simulate $stowable_packages"
alias install-all-links="install-links $stowable_packages"
alias reinstall-all-links-simulate="reinstall-links-simulate $stowable_packages"
alias reinstall-all-links="reinstall-links $stowable_packages"
alias uninstall-all-links-simulate="uninstall-links-simulate $stowable_packages"
alias uninstall-all-links="uninstall-links $stowable_packages"

# easy to remember time and date
alias now='date +"%m-%d-%Y %l:%M:%S%p %Z"'
alias today='date +"%m-%d-%Y"'

# networking ports, interface, ping...
if [[ "$(uname)" == "Darwin" ]] then
    alias ports='lsof -nP +c 15 | egrep "IPv[46]"'
else
    alias ports='netstat -tulanp'
fi
alias netiface=get-active-network-interface
alias ping='ping -c 3'
alias pingfast='ping -c 10 -i .1'

# mounts, disks, dirsize, file count
alias mounts='mount | column -t'
alias disks='df --total --human-readable'
alias dirsize=get-dirsize
alias file-count='/bin/ls -1 | wc -l'

# always trying a new system monitor tool
alias top='bpytop'

# weather and active network adapter/ip address
alias weather=get-full-weather-info
alias netinfo=get-network-info

# global aliases for tools which are often PIPED into or out of
alias -g LESS='less -RFX'
alias -g XML='tidy -xml -q -i - | bat'
alias -g UUID=uuid-generator
alias -g HEX='hexdump -v -C'

# make it easy to add a path to the $PATH
alias update-path='export PATH=`pwd`:$PATH'

# make it simple to find the full path of any file/symlink/dir/etc.
alias abs_path=abs-path

# print environment variables, zsh functions or source code files using pysegmentize to color-ize contents
alias pprint=pretty-print

# these args are impossible to remember
alias 7zenc='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p'
alias 7ztest='7z l -slt'
alias 7zdec='7z x'

# Both of the following are keystroke savers...
alias cls='clear && echo -en "\e[3J"'
alias x='exit'

# Package mantanaince applications and commands
if [[ "$(uname)" == "Linux" ]] then
    alias update=apt-update
    alias upgrade=apt-upgrade
else
    alias update=brew-update
    alias upgrade=brew-upgrade
fi

# If on macOS the best markdown editor/viewer found is typora. Unfortunately they don't have any CLI support.
#  This alias enables both a 'typora' command (which nobody will ever remember) and a 'markdown' command
if [[ "$(uname)" == "Darwin" ]] then
    alias chrome='open -a "Google Chrome"'
    alias google-chrome='open -a "Google Chrome"'
    alias typora='open -a typora'
    alias mark-down='open -a typora'
    alias eject='diskutil unmountDisk force'
fi

#
# It used to be that all these aliases were prefaced by unbuffer.  I finally figured out the reason for unbuffer.
#  When these applications would pipe themselves into 'less' or any other app they were unable to know if they were
#  still in a terminal (tty) or whether they were going to a file.  To be careful, they assumed they were going to
#  a file and they stripped the terminal color highlighting from their output.  The one thing that unbuffer does is
#  it communicates to the application it calls that its output is always going to a terminal (tty).  For this reason
#  the application never strips off the color highlighting when its called by unbuffer.
#
# There is a better and more obvious fix than using unbuffer.  This is great news because unbuffer adds another
#  dependency and occasionally fails for some reason.  The better solution is to simply tell the application to
#  always output color.  Since the application is told to always output color it no longer needs to detect whether
#  its output is a terminal (tty) or a file.  Of course, this option was hiding in plain sight... --color=always.
#
# Hence, all of the application calls below either have '--color=always' or the outdated Darwin '/bin/ls' has to
#  define 'CLICOLOR_FORCE=1 CLICOLOR=1' before its called.
#
# Not knowing it could be fixed as simple as that I scoured the internet to find a solution.  I finally found
#  that zsh could create a virtual tty environment and call an application within it.  This code is wrapped
#  within a function and placed in .zsh_functions named 'teletype'.
#
#  Pretty nifty -- but now un-needed and should be deleted.
#
if [[ $(command -v exa) ]] then
    alias  ls='exa --all --long --header --group --links --sort=Name --time-style=default --git --icons --color=always'
    alias  la='exa --all --long --header --group --links --sort=Name --time-style=default --git --icons --color=always'
    alias   l='exa --all --all --long --header --group --links --sort=Name --time-style=default --git --icons --color=always'
    alias  ll='exa --all --all --long --header --group --links --sort=Name --time-style=default --git --icons --color=always'
    alias lsa='exa --all --all --long --header --group --links --sort=Name --time-style=default --git --icons --color=always'
    alias dir='exa --all --long --header --group --links --sort=.Name --time-style=default --git --icons --color=always'
    alias lst='exa --all --long --header --group --links --sort=oldest --time-style=default --git --icons --color=always'
elif [[ $(command -v lsd) ]] then
    alias  ls='lsd --almost-all --long --color always'
    alias  la='lsd --almost-all --long --color always'
    alias   l='lsd --all --long --color always'
    alias  ll='lsd --all --long --color always'
    alias lsa='lsd --all --long --color always'
    alias dir='lsd --almost-all --long --color always'
    alias lst='lsd --almost-all --long --timesort --color always'
elif [[ $(command -v gls) ]] then
    # On Mac OSX our last chance of getting into the else loop is if the coreutils brew package has been installed
    #  and we can use the gnu-ls binary.
    alias  ls='gls --almost-all -l --classify --human-readable --color=always'
    alias  la='gls --almost-all -l --classify --human-readable --color=always'
    alias   l='gls --all -l --classify --human-readable --color=always'
    alias  ll='gls --all -l --classify --human-readable --color=always'
    alias lsa='gls --all -l --classify --human-readable --color=always'
    alias dir='gls --almost-all -l --classify --human-readable --color=always'
    alias lst='gls --almost-all -l --classify --human-readable --color=always -t'
else
    if [[ "$(uname)" == "Darwin" && ! $(/bin/ls --help > /dev/null 2>&1) ]] then
        # On Mac OSX the ls included only takes short options and will not allow help -- pile of garbage
        alias  ls='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -AliFGh'
        alias  la='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -AlFGh'
        alias   l='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -alFGh'
        alias  ll='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -alFGh'
        alias lsa='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -alFGh'
        alias dir='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -AlFGh'
        alias lst='CLICOLOR_FORCE=1 CLICOLOR=1 /bin/ls -AlFGht'
    else
        alias  ls='/bin/ls --almost-all -l --classify --human-readable --color=always'
        alias  la='/bin/ls --almost-all -l --classify --human-readable --color=always'
        alias   l='/bin/ls --all -l --classify --human-readable --color=always'
        alias  ll='/bin/ls -l --classify --human-readable --color=always'
        alias lsa='/bin/ls --all -l --classify --human-readable --color=always'
        alias dir='/bin/ls --almost-all -l --classify --human-readable --color=always'
        alias lst='/bin/ls --almost-all -l --classify --human-readable --color=always -t'
    fi
fi



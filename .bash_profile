# .bash_profile

# environment variables
export PATH=$PATH:$HOME/settings:$HOME/scripts

# prompt_command is a callback which is called right before the prompt is printed
# this sets the tab title to the current working directory in iTerm2
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

function set_prompt {
    local BLACK="\[\033[0;30m\]"
    local BLACKBOLD="\[\033[1;30m\]"
    local RED="\[\033[0;31m\]"
    local REDBOLD="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local GREENBOLD="\[\033[1;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local YELLOWBOLD="\[\033[1;33m\]"
    local BLUE="\[\033[0;34m\]"
    local BLUEBOLD="\[\033[1;34m\]"
    local PURPLE="\[\033[0;35m\]"
    local PURPLEBOLD="\[\033[1;35m\]"
    local CYAN="\[\033[0;36m\]"
    local CYANBOLD="\[\033[1;36m\]"
    local WHITE="\[\033[0;37m\]"
    local WHITEBOLD="\[\033[1;37m\]"
    local RESETCOLOR="\[\e[00m\]"

    export PS1="$BLUE\w$RED"'$(vcprompt -f %b)'"$BLUE → $RESETCOLOR"
    #export PS1='\w$(vcprompt -f %b)> '
}

# setting the PS1 environment variable will set the prompt to a specific color and the working directory
set_prompt

# for use with the GO language installation
export GOROOT=/usr/local/go
export GOPATH=$HOME/scripts

# User specific aliases and functions
alias df='df -h'
alias ls='ls -laG'
alias dir='ls -laG'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias edit='vim'
alias view='vim'
alias cpwp='rsync -aP'
alias mvwp='rsync -aP --remove-source-files'
alias update-path='export PATH=$PATH:`pwd`'
alias waf-clean='rm -rf .waf-* build pyenv .lock-*'
alias pylint='pylint -r n --rcfile=~/settings/pylintrc'

# aliases to set the color of the tab in iTerm2
alias tab-blank='echo -n -e "\033]6;1;bg;*;default\a"'
alias tab-lime='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;green;brightness;255\a"'
alias tab-red='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a"'
alias tab-blue='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;blue;brightness;255\a"'
alias tab-yellow='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;255\a\033]6;1;bg;blue;brightness;0\a"'
alias tab-purple='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;255\a"'
alias tab-orange='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a"'
alias tab-aqua='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;255\a\033]6;1;bg;blue;brightness;255\a"'
alias tab-redder='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;128\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;0\a"'
alias tab-olive='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;128\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a"'
alias tab-green='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a"'
alias tab-teal='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;128\a"'
alias tab-navy='echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;128\a"'

# set the color of the tabs in iTerm2 for this Mac
tab-purple

# for each new bash shell print out the hostname and network information
echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

# MacPorts Installer addition on 2012-05-06_at_04:38:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

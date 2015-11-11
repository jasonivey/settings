# .bash_profile

# environment variables
export PATH=$PATH:$HOME/settings:$HOME/scripts
export PS1='\w$(vcprompt -f %b)> '

export GOROOT=/usr/local/go
export GOPATH=$HOME/scripts

# User specific aliases and functions
alias df='df -h'
alias ls='ls -laG'
alias dir='ls -laG'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias edit='vim'
alias view='vim'
alias cpwp='rsync -aP'
alias mvwp='rsync -aP --remove-source-files'
alias update-path='export PATH=$PATH:`pwd`'
alias waf-clean='rm -rf .waf-* build pyenv .lock-*'
alias pylint='pylint -r n --rcfile=~/settings/pylintrc'

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

tab-purple

echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

# MacPorts Installer addition on 2012-05-06_at_04:38:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

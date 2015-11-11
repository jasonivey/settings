# .bash_aliases
# Alias definitions.

# environment variables
export PS1='\w$(vcprompt -f %b)> '
export PATH=$PATH:$HOME/settings:$HOME/scripts
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
#export PROMPT_COMMAND='echo -ne "\033]0;`hostname` - ${PWD/#$HOME/~}\007"'

# aliases
alias df='df -h'
alias ls='ls -la --color=auto'
alias dir='ls -la --color=auto'
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

echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

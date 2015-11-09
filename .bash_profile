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
lias pylint='pylint -r n --rcfile=~/settings/pylintrc'

echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

# MacPorts Installer addition on 2012-05-06_at_04:38:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

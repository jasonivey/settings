# .bash_profile

export PATH=$PATH:~/settings:~/bin:~/scripts
export PS1='\w$(vcprompt -f %b)> '

# User specific aliases and functions
alias df='df -h'
alias ls='ls -laG'
alias dir='ls -laG'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias edit='vi'

alias copy='cp'
alias ren='mv'
alias md='mkdir'

export GOROOT=/usr/local/go
export GOPATH=/usr/local/go

# MacPorts Installer addition on 2012-05-06_at_04:38:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

echo 'Hostname:         '`hostname`
python ~/scripts/network_info.py

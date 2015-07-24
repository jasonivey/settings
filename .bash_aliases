# .bash_aliases
# Alias definitions.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# aliases
alias df='df -h'
alias ls='ls -la --color=auto'
alias dir='ls -la --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias edit='vim'
alias copy='cp'
alias ren='mv'
alias md='mkdir'

# environment variables
export PS1='\w$(vcprompt -f %b)> '
export PATH=$PATH:~/settings:~/bin:~/scripts

# display hostname and ip addresses
IP_ETH0=$(ifconfig eth0 | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)
IP_ETH1=$(ifconfig eth1 | grep '\<inet\>' | sed -n '1p' | tr -s ' ' | cut -d ' ' -f3 | cut -d ':' -f2)

echo 'Hostname:         '`hostname`
echo 'IP Address eth0:  '$IP_ETH0
echo 'MAC Address eth0: '`ifconfig | grep 'eth0' | tr -s ' ' | cut -d ' ' -f5`
echo 'IP Address eth1:  '$IP_ETH1
echo 'MAC Address eth1: '`ifconfig | grep 'eth1' | tr -s ' ' | cut -d ' ' -f5`

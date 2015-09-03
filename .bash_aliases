# .bash_aliases
# Alias definitions.

# environment variables
export PS1='\w$(vcprompt -f %b)> '
export PATH=$PATH:$HOME/settings:$HOME/scripts

# aliases
alias df='df -h'
alias ls='ls -la --color=auto'
alias dir='ls -la --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias edit='vim'
alias cpwp='rsync -aP'
alias mvwp='rsync -aP --remove-source-files'

echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

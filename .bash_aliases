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
alias view='vim'
alias cpwp='rsync -aP'
alias mvwp='rsync -aP --remove-source-files'
alias update-path='export PATH=$PATH:`pwd`'
alias waf-clean='rm -rf .waf-* build pyenv .lock-*'
alias pylint='pylint -r n --rcfile=~/settings/pylintrc'

echo 'Hostname:         '`hostname`
python $HOME/scripts/network_info.py

# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

# In some OS's (Mac OS) it may be necessary to manually set your language environment
#  but on others (Linux) they are already defined in /etc/default/locale
if [[ -z "$LC_ALL" && "$(uname)" == "Darwin" ]] then
    export LC_ALL='en_US.UTF-8'
fi
if [[ -z "$LANG" && "$(uname)" == "Darwin" ]] then
    export LANG='en_US.UTF-8'
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DEFAULT_USER="jasoni"
export PATH=$PATH:.
export PAth=$PATH:$HOME/settings
export PATH=$PATH:$HOME/dev/scripts

if [[ "$(uname)" == "Darwin" ]] then
    export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/Current"
    export PATH=$PATH:$JAVA_HOME/Commands
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/clang_9.0.0/lib
    export PATH=$PATH:/usr/local/Cellar/llvm/9.0.1/bin
    export PATH=$PATH:$HOME/Library/Python/3.7/bin
elif [[ "$(uname -s)" == "Linux" ]] then
    export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
    export PATH=$PATH:$JAVA_HOME/bin
    export PATH=$PATH:$HOME/.nix-profile/bin
fi

export BAT_THEME="zenburn"
export PAGER="less -RFX"
export BAT_PAGER="less -RFX"
export BAT_CONFIG_PATH="$HOME/settings/bat.conf"

# If you don't remember to use batman
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANROFFOPT="-c"

# RipGrep needs to know where its configuration file is located
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#export PATH=/Applications/MacVim.app/Contents/bin:$HOME/settings:$HOME/scripts:/usr/local/sbin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

# Ensure you modify $HOME/.oh-my-zsh/themes/agnoster.zsh-theme by commenting out the call to this method: #prompt_context
# This will ensure there isn't the hostname and username printed on every line

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump # install in mac/linux
    brew
    chucknorris  # fortune/cowsay
    command-not-found # install in linux
    #common-aliases
    debian # apt
    dircycle
    encode64 # base64
    extract
    git
    git-extras
    git-flow
    httpie
    history
    jsontools
    osx # brew install shpotify
    pyenv
    pylint
    python
    rand-quote
    screen
    sudo
    urltools
    z
    zsh-syntax-highlighting
    zsh-autosuggestions
)
#vi-mode

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"


# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]] then
#    export EDITOR='vim'
#else
#    export EDITOR='mvim'
#fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# load the zsh completion system
autoload -Uz compinit && compinit

# load bashcompinit for some old bash completions
#autoload bashcompinit && bashcompinit

if [[ -d "/nix" ]] then
    # load the nix package installer
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

#### ALIASES ####

# functions to set the color of the tab in iTerm2
tab-blank() { echo -n -e "\033]6;1;bg;*;default\a" ; }
tab-lime() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;green;brightness;255\a" ; }
tab-red() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a" ; }
tab-blue() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;blue;brightness;255\a" ; }
tab-yellow() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;255\a\033]6;1;bg;blue;brightness;0\a" ; }
tab-purple() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;255\a" ; }
tab-orange() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;255\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a" ; }
tab-aqua() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;255\a\033]6;1;bg;blue;brightness;255\a" ; }
tab-redder() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;128\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;0\a" ; }
tab-olive() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;128\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a" ; }
tab-green() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;0\a" ; }
tab-teal() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;128\a\033]6;1;bg;blue;brightness;128\a" ; }
tab-navy() { echo -n -e "\033]6;1;bg;*;default\a\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;128\a" ; }


set-cscope() {
    eval `find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' > ./cscope.files`
    eval `cscope -b`
}

dev() {
    cd $HOME/dev/$1
}

set-tab-color() {
    if [ -e "$HOME/settings/.bash_color" ]; then
        tab-$(head -n 1 $HOME/settings/.bash_color)
    fi
}

get-network-info() {
    if [[ -e "$HOME/scripts/network_info.py" ]] then
        python3 $HOME/scripts/network_info.py
    fi
}
get-weather-info() {
    if [[ -e "$HOME/scripts/weather_info.py" ]] then
        python3 $HOME/scripts/weather_info.py
    fi
}

get-full-weather-info() {
    if [[ -e "$HOME/scripts/weather_info.py" ]] then
        python3 $HOME/scripts/weather_info.py --full-report
    fi
}

alias zshconfig="vim $HOME/.zshrc"
alias ohmyzsh="vim $HOME/.oh-my-zsh"

if [[ $(command -v exa) ]] then
    # The default 'ls -l -a' but also adding the header, showing the date nicely and showing git status
    alias ls="unbuffer exa --all --long --header --group --sort=.Name --time-style=long-iso --git --icons"
    # List all the files sorting by modified date, reversing the order, to show the newest on top
    alias lst="unbuffer exa --all --long --header --group --sort=oldest --time-style=long-iso --git --icons"
    # The default 'ls -l -a' but also adding the header, showing the date nicely and showing git status
    alias dir="unbuffer exa --all --long --header --group --sort=CName --time-style=long-iso --git --icons"
else
    # The default 'ls -l -a'
    alias ls="ls -l --all --color=always --time-style=long-iso --classify --human-readable"
    # List all the files sorting by modified date to show the newest on top
    alias lst="ls -l --all --color=always --time-style=long-iso --classify --human-readable -t"
    # The default 'ls -l -a'
    alias dir="ls -l --all --color=always --time-style=long-iso --classify --human-readable"
fi

alias df='df -h'
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -i"
alias 7zenc='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p'
alias 7ztest='7z l -slt'
alias 7zdec='7z x'
alias matrix='cmatrix -bs -C red'
alias weather=get-full-weather-info
alias netinfo=get-network-info
alias cls='clear && echo -en "\e[3J"'
alias x="exit"

alias ide='vim -O3'
alias edit='vim'
alias view='vim'

set-tab-color

# for each new shell print out the hostname, network information and weather
get-network-info
get-weather-info

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

zmodload zsh/zpty

teletype() {
    # Applications will often attempt to detect if output is going to a TTY (terminal) or a file.  If the application
    #  cannot specify --color=always it will assume it's destination is a file.  The following code creates a virtual
    #  zsh tty and launches the application within that context.  The application then knows its outputting to a TTY
    #  (terminal) and will not strip the embedded color codes.
    zpty pty-${UID} ${1+$@}
    if [[ ! -t 1 ]];then
        setopt local_traps
        trap '' INT
    fi
    zpty -r pty-${UID}
    zpty -d pty-${UID}
}

open-vscode() {
    if (($# > 0)) then
        HUSH_LOGIN_INFO=1 VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $@
    else
        HUSH_LOGIN_INFO=1 VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode"
    fi
}

goclean() {
    local pkg=$1
    local ost
    local cnt

    # Clean removes object files from package source directories (ignore error)
    echo "go clean -i $pkg &>/dev/null"
    go clean -i $pkg &>/dev/null

    # Set local variables
    [[ "$(uname -m)" == "x86_64" ]] && ost="$(uname)";ost="${ost:l}_amd64" && cnt="${pkg//[^\/]}"
    # bash lowercase: ost="${ost,,}_amd64", zsh lowercase: ost="${ost:l}_amd64"
    #[[ "$(uname -m)" == "x86_64" ]] && ost="$(uname)";ost="${ost,,}_amd64" && cnt="${pkg//[^\/]}"
    #echo "ost: $ost, cnt: $cnt"

    # Delete the source directory and compiled package directory(ies)
    if (( ${#cnt} == 2 )) then
        echo "rm -rf \"${GOPATH%%:*}/src/${pkg%/*}\""
        rm -rf "${GOPATH%%:*}/src/${pkg%/*}"
        echo "rm -rf \"${GOPATH%%:*}/pkg/${ost}/${pkg%/*}\""
        rm -rf "${GOPATH%%:*}/pkg/${ost}/${pkg%/*}"
    elif (( ${#cnt} > 2 )) then
        echo "rm -rf \"${GOPATH%%:*}/src/${pkg%/*/*}\""
        rm -rf "${GOPATH%%:*}/src/${pkg%/*/*}"
        echo "rm -rf \"${GOPATH%%:*}/pkg/${ost}/${pkg%/*/*}\""
        rm -rf "${GOPATH%%:*}/pkg/${ost}/${pkg%/*/*}"
    fi
    unset pkg, ost, cnt
}

gitdiff() {
    preview="git diff $@ --color=always -- {-1}"
    git diff $@ --name-only | sk -m --ansi --preview $preview
}

de-duplicate-zsh-paths() {
    # This ensures that duplicate paths are not persisted to the PATH environment
    #  variable regaurdless of how many times source .zshrc is executed
    typeset -U PATH
    # Shouldn't have to keep track of NIX paths but... oh well!
    typeset -U NIX_PATH
    typeset -U NIX_PROFILES
}

pretty-print-env-variable() {
    [ $# -gt 0 ] && local env_var_=$1 || local env_var_="PATH"
    if [[ ${(P)env_var_} == *":"* ]] then
        printf "\e[32m$env_var_\e[37;1m:\n    ${${(P)env_var_}//:/\\n    }\e[0m\n"
    elif [[ ${(P)env_var_} == *";"* ]] then
        printf "\e[32m$env_var_\e[37;1m:\n    ${${(P)env_var_}//;/\\n    }\e[0m\n"
    elif [[ ${(P)env_var_} == *" "* ]] then
        printf "\e[32m$env_var_\e[37;1m:\n    ${${(P)env_var_}// /\\n    }\e[0m\n"
    else
        printf "\e[32m$env_var_\e[37;1m: ${(P)env_var_}\e[0m\n"
    fi
}

pretty-print-info() {
    printf "\e[32mINFO\e[37;1m: $1\e[0m\n"
}

pretty-print-error() {
    printf "\e[31mERROR\e[37;1m: $1\e[0m\n"
}

pretty-print() {
    if [[ $# == 0 ]] then
        # if the user did not pass any argument then assume they want the
        #  PATH environment variable pretty printed
        pretty-print-env-variable
    fi
    set | grep --max-count=1 -e "^$1=.*$" &>/dev/null
    if [[ $? == 0 ]] then
        # if the argument is a variable of any type then pretty print that
        pretty-print-env-variable "$1"
    elif declare -Ff "$1" >/dev/null; then
        # if the argument is a function name then print the function definition
        whence -f $1
    elif [[ -r $1 ]] then
        # if the argument is a file -- then pretty print it using pygmentize
        pygmentize -g -O "style=fruity,linenos=1" -f terminal16m $1
    else
        pretty-print-error "\"$1\" is not a environment variable, function or file name"
    fi
}

set-cscope() {
    eval `find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' > ./cscope.files`
    eval `cscope -b`
}

goto-dev-dir() {
    if [[ $# -gt 0 && -d $HOME/dev/$1 ]] then
        cd $HOME/dev/$1
    else
        cd $HOME/dev
    fi
}

make-dev-build-dir() {
    if [[ $# -eq 0 ]] then
        cd $HOME/dev
        pretty-print-info "unable to clean and go into build directory because there was no dev prroject specified"
    else
        local dev_dir_=$(realpath $HOME/dev/$1)
        local build_dir_=$(realpath $HOME/dev/$1/build)
        [ -d "$build_dir_" ] && /bin/rm -rf "$build_dir_"
        if [[ -d "$build_dir_" ]] then
            pretty-print-error "unable to delete $build_dir_"
        else
            mkdir "$build_dir_"
        fi
        cd "$build_dir_"
    fi
}

get-login-info() {
    if [[ -e "$HOME/settings/mmotd" ]] then
        "$HOME/settings/mmotd"
    elif [[ -e "$HOME/scripts/login_info.py" ]] then
        python3 $HOME/scripts/login_info.py
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

uuid-generator() {
    if [[ ! $(uuidgen --verbose > /dev/null 2>&1) ]] then
        echo `uuidgen | tr -d '-' | tr '[:upper:]' '[:lower:]'`
    else
        echo `uuidgen --random | sed 's/-//g'`
    fi
}

abs-path() {
    [ $# -gt 0 ] && local dir_="$1" || local dir_="$(pwd -P)"
    printf "\e[32m%s\e[0m\e[1m: %s\e[0m\n" "realpath" "$(realpath -LPe $dir_)"
}

get-dirsize() {
    [ $# -gt 0 ] && local dir_="$1" || local dir_="$(pwd -P)"
    du -hcs "$dir_" | sed -n '1p;$p' | awk -f $HOME/scripts/dirsize.awk
}

get-include-paths() {
    python3 $HOME/scripts/get_include_paths.py
}

go-to-stdlib-include() {
    local stdlib_dir=''
    python3 $HOME/scripts/get_include_paths.py "$@" | while read output_str
    do
        echo $output_str;
        if [[ $output_str =~ .*c\\+\\+.* ]] then
            if [[ ${#stdlib_dir} -eq 0 || ${#output_str} -lt ${#stdlib_dir} ]] then
                stdlib_dir=$output_str;
            fi
        fi
    done
    [[ ${#stdlib_dir} -gt 0 ]] && cd $stdlib_dir
}

go-to-system-include() {
    local system_include_dir=''
    python3 $HOME/scripts/get_include_paths.py "$@" | while read output_str
    do
        echo $output_str;
        if [[ $output_str =~ .*\\.sdk\\/usr\\/include$ ]] then
            if [[ ${#system_include_dir} -eq 0 || ${#output_str} -lt ${#system_include_dir} ]] then
                system_include_dir=$output_str;
            fi
        fi
    done
    [[ ${#system_include_dir} -gt 0 ]] && cd $system_include_dir
}

get-active-network-interface() {
    ip route get 1.1.1.1 | awk '{ if (NR == 1) { print $5; } }'
}

get-confirmation() {
    read "RESPONSE?$1. Continue [Y/n]? "
    if [[ ( -z $RESPONSE || $RESPONSE =~ ^[Yy].*$ ) ]] then
        echo 1;
    else
        echo 0;
    fi
}

set-tab-color() {
    if [ -e "$HOME/settings/zsh/color.zsh" ]; then
        echo $(head -n 1 $HOME/settings/zsh/color.zsh) | python3 $HOME/scripts/set_tab_color.py
    elif [ -e "$HOME/.bash_color" ]; then
        echo $(head -n 1 $HOME/.bash_color) | python3 $HOME/scripts/set_tab_color.py
    fi
}

apt-update() {
    sudo apt update
}

apt-upgrade() {
    sudo apt dist-upgrade
}

brew-update() {
    brew update &&
    brew outdated &&
    brew outdated --cask
}

brew-upgrade() {
    setopt localoptions ERR_RETURN
    echo "running brew upgrade"
    brew upgrade
    echo "running brew outdated --casks"
    local outdated_count=$(brew outdated --cask | awk 'BEGIN { i = 0 } { ++i } END { print i }')
    if [ $outdated_count -ne 0 ]; then
        echo "running brew reinstall (brew outdated --casks)"
        brew reinstall $(brew outdated --cask)
    fi
    echo "running brew cleanup"
    brew cleanup
}

goto_root() {
    root="/"
    curr_dir="$(pwd -P)"
    while [ $curr_dir != "/" ]; do
        git_repo="$curr_dir/.git"
        if [ -d "${git_repo}" ]; then
            cd $(realpath -LPe $curr_dir)
        fi
        curr_dir="$(dirname "$curr_dir")"
    done
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

ssh-vpn() {
    ssh -F $HOME/tools/algo/configs/$1/ssh_config $1
}

restart() {
    let confirmation=$(get-confirmation "Reboot now")
    if (( $confirmation == 1 )); then
        echo "Rebooting now ...1..2..3..."
        if [[ "$(uname -s)" == "Darwin" ]] then
            # Shows no confirmation dialog
            #osascript -e 'tell app "System Events" to restart'
            # Shows a confirmation dialog
            osascript -e 'tell app "loginwindow" to «event aevtrrst»'
        else
            sudo systemctl reboot
        fi
    else
        echo "Not rebooting now..."
    fi
}

shutoff() {
    let confirmation=$(get-confirmation "Shutdown now")
    if (( $confirmation == 1 )); then
        echo "Shutting down now ...1..2..3..."
        if [[ "$(uname -s)" == "Darwin" ]] then
            # Shows no confirmation dialog
            #osascript -e 'tell app "System Events" to shut down'
            # Shows a confirmation dialog
            osascript -e 'tell app "loginwindow" to «event aevtrsdn»'
        else
            sudo systemctl halt
        fi
    else
        echo "Not shutting down now..."
    fi
}

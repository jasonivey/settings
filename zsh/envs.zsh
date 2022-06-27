#!/usr/bin/env zsh
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=zsh

add_dir_to_path_end() {
    [ -d "$1" ] && export PATH="$PATH:$1"
}

add_dir_to_path() {
    [ -d "$1" ] && export PATH="$1:$PATH"
}

add_dir_to_fpath() {
    if [[ -d "$1" ]] then
        if [[ $FPATH && ${FAPATH-x} ]] then
            FPATH="$FPATH:$1"
        else
            FPATH="$1"
        fi
    fi
}

add_dir_to_pkg_config_path() {
    if [[ -d "$1" ]] then
        if [[ $PKG_CONFIG_PATH && ${PKG_CONFIG_PATH-x} ]] then
            export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$1"
        else
            export PKG_CONFIG_PATH="$1"
        fi
    fi
}

add_dir_to_include_path() {
    if [[ -d "$1" ]] then
        if [[ $CXXFLAGS && ${CXXFLAGS-x} ]] then
            export CXXFLAGS="$CXXFLAGS -isystem$1"
        else
            export CXXFLAGS="-isystem$1"
        fi
        if [[ $CFLAGS && ${CFLAGS-x} ]] then
            export CFLAGS="$CFLAGS -isystem$1"
        else
            export CFLAGS="-isystem$1"
        fi
    fi
}

add_to_linker_environment_variable() {
    if [[ $LDFLAGS && ${LDFLAGS-x} ]] then
        export LDFLAGS="$LDFLAGS $1"
    else
        export LDFLAGS="$1"
    fi
}

add_dir_to_linker_path() {
    if [[ -d "$1" ]] then
        add_to_linker_environment_variable "-L$1"
    fi
}

# set the environment variable $1 from the list of values $2..$n to the first
#  value which is an executable binary
set_env_variable_from_list() {
    env_variable_name="$1"
    env_variable_values=("${@:2}")
    for i in "${env_variable_values[@]}"; do
        if command -v "$i" &>/dev/null; then
            export "$env_variable_name=$i";
            break
        fi
    done
}

# setup history file, size and filesize
export HISTFILE="$HOME/.zsh_history"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HIST_STAMPS="%m-%d-%Y %l:%M:%S%p %Z"

# always have the current directory in the path
export PATH="$PATH:."

# add the following to PATH regardless of platform
add_dir_to_path "/usr/local/bin"
add_dir_to_path "/usr/local/sbin"
add_dir_to_path "$HOME/settings"
add_dir_to_path "$HOME/scripts"
add_dir_to_path "$HOME/.local/bin"
add_dir_to_path "$HOME/.cargo/bin"
add_dir_to_path "$HOME/.iterm2"

if [[ "$(uname)" == "Darwin" ]] then
    # Setup JAVA environment variables
    if [[ -x "/usr/libexec/java_home" ]] then
        if "/usr/libexec/java_home" &>/dev/null; then
            export JAVA_HOME=$("/usr/libexec/java_home")
        fi
    fi

    # For using a2x for manpage generation
    [ -e "/usr/local/etc/xml/catalog" ] && export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

    # Add various fpath directories for ZSH completions
    add_dir_to_fpath "/usr/local/share/zsh/functions"
    add_dir_to_fpath "/usr/local/share/zsh/site-functions"

    # Setup libressl environment variables -- uncomment when needed
    #[ -d "/usr/local/opt/libressl" ] && local component_dir="/usr/local/opt/libressl" || local component_dir="$(brew --prefix libressl)"
    #add_dir_to_path "$component_dir/bin"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup curl environment variables -- uncomment when needed
    #[ -d "/usr/local/opt/curl" ] && local component_dir="/usr/local/opt/curl" || local component_dir="$(brew --prefix curl)"
    #add_dir_to_path "$component_dir/bin"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup sqlite3 environment variables -- uncomment when needed
    [ -d "/usr/local/opt/sqlite" ] && local component_dir="/usr/local/opt/sqlite" || local component_dir="$(brew --prefix sqlite)"
    add_dir_to_path "$component_dir/bin"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup binutils variables
    [ -d "/usr/local/opt/binutils" ] && local component_dir="/usr/local/opt/binutils" || local component_dir="$(brew --prefix binutils)"
    #add_dir_to_path "$component_dir/bin"
    add_dir_to_linker_path "$component_dir/lib"
    add_dir_to_include_path "$component_dir/include"

    # Setup LLVM/clang C++ environment variables -- for brew versions of llvm
    # [ -d "/usr/local/opt/llvm" ] && local component_dir="/usr/local/opt/llvm" || local component_dir="$(brew --prefix llvm)"
    # add_dir_to_path "$component_dir/bin"
    # add_to_linker_environment_variable "-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
    # add_dir_to_include_path "$component_dir/include"

    # Setup LLVM/clang C++ environment variables -- for non-brew versions of llvm (i.e. llvm-14)
    [ -d "/usr/local/llvm/14.0.3_0" ] && local component_dir="/usr/local/llvm/14.0.3_0"
    add_dir_to_path "$component_dir/bin"
    add_to_linker_environment_variable "-L/usr/local/llvm/14.0.3_0/lib -Wl,-rpath,/usr/local/llvm/14.0.3_0/lib"
    # The builtin paths within the llvm-14 compiler point towards '/System/Library/Frameworks' and
    #  '/Library/Frameworks' which would work if the command line tools were installed via XCode but
    #  most brew users have it installed from the command line.  Hence the following addition to the
    #  linker flag.
    add_to_linker_environment_variable "-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -Wl,-rpath,/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
    add_dir_to_include_path "$component_dir/include"

    # Add all of the gnu-variant duplicate (newer) versions of binaries
    [ -d "/usr/local/opt/unzip" ] && local component_dir="/usr/local/opt/unzip" || local component_dir="$(brew --prefix unzip)"
    add_dir_to_path "$component_dir/bin"

    # BEGIN: relationship... the following two paths are related
    [ -d "/usr/local/opt/coreutils" ] && local component_dir="/usr/local/opt/coreutils" || local component_dir="$(brew --prefix coreutils)"
    add_dir_to_path "$component_dir/libexec/gnubin"

    # The md5sha1sum MUST come after the coreutils since it overlaps md5sum, sha1sum and adds ripemd160sum.
    #  Declaring this statement after the coreutils 'add_dir_to_path' statement un-intuitively modifies
    #  the PATH so the md5sha1sum bin directory will come before coreutils.
    [ -d "/usr/local/opt/md5sha1sum" ] && local component_dir="/usr/local/opt/md5sha1sum" || local component_dir="$(brew --prefix md5sha1sum)"
    add_dir_to_path "$component_dir/bin"
    # END: relationship...

    [ -d "/usr/local/opt/make/libexec/gnubin" ]    && add_dir_to_path "/usr/local/opt/make/libexec/gnubin"    || add_dir_to_path "$(brew --prefix make)/libexec/gnubin"
    [ -d "/usr/local/opt/grep/libexec/gnubin" ]    && add_dir_to_path "/usr/local/opt/grep/libexec/gnubin"    || add_dir_to_path "$(brew --prefix grep)/libexec/gnubin"
    [ -d "/usr/local/opt/gnu-sed/libexec/gnubin" ] && add_dir_to_path "/usr/local/opt/gnu-sed/libexec/gnubin" || add_dir_to_path "$(brew --prefix gnu-sed)/libexec/gnubin"
    [ -d "/usr/local/opt/gnu-getopt/bin" ]         && add_dir_to_path "/usr/local/opt/gnu-getopt/bin"         || add_dir_to_path "$(brew --prefix gnu-getopt)/bin"

    # Setup ruby binaries before system ruby -- uncomment when needed
    #[ -d "/usr/local/opt/ruby" ] && local component_dir="/usr/local/opt/ruby" || local component_dir="$(brew --prefix ruby)"
    #add_dir_to_path "$component_dir/libexec/gembin"
    #add_dir_to_path "$component_dir/bin"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup TCL-TK environment variables -- uncomment when needed -- needed for compiling VIM
    #[ -d "/usr/local/opt/tcl-tk" ] && local component_dir="/usr/local/opt/tcl-tk" || local component_dir="$(brew --prefix tcl-tk)"
    #add_dir_to_path "$component_dir/bin"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Ignore the following error from Tcl/Tk since brew installed python relies on macOS version of Tcl/Tk which is
    #  outdated.  Make sure to follow-up on this variable to ensure it is needed in the future.
    export TK_SILENCE_DEPRECATION=1

    # No longer remove older versions of apps when updating/installing new apps (i.e. do not run `brew cleanup`)
    export HOMEBREW_NO_INSTALL_CLEANUP=TRUE

    # Setup zlib environment variables
    [ -d "/usr/local/opt/zlib" ] && local component_dir="/usr/local/opt/zlib" || local component_dir="$(brew --prefix zlib)"
    add_dir_to_linker_path "$component_dir/lib"
    add_dir_to_include_path "$component_dir/include"
    add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup readline environment variables
    [ -d "/usr/local/opt/readline" ] && local component_dir="/usr/local/opt/readline" || local component_dir="$(brew --prefix readline)"
    add_dir_to_linker_path "$component_dir/lib"
    add_dir_to_include_path "$component_dir/include"
    add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup OpenSSL environment variables
    [ -d "/usr/local/opt/openssl" ] && export OPENSSL_ROOT_DIR="/usr/local/opt/openssl" || export OPENSSL_ROOT_DIR="$(brew --prefix openssl)"
    add_dir_to_path "$OPENSSL_ROOT_DIR/bin"
    add_dir_to_linker_path "$OPENSSL_ROOT_DIR/lib"
    add_dir_to_include_path "$OPENSSL_ROOT_DIR/include"
    add_dir_to_pkg_config_path "$OPENSSL_ROOT_DIR/lib/pkgconfig"

    # Setup oniguruma (modern and flexible regular expressions library) environment variables -- uncomment when needed
    #[ -d "/usr/local/opt/oniguruma" ] && local component_dir="/usr/local/opt/oniguruma" || local component_dir="$(brew --prefix oniguruma)"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # pip install -r $HOME/scripts/requirements.txt

    # Setup the QT library environment variables -- uncomment when needed
    #[ -d "/usr/local/opt/qt" ] && local component_dir="/usr/local/opt/qt" || local component_dir="$(brew --prefix qt)"
    #add_dir_to_path "$component_dir/bin"
    #add_dir_to_include_path "$component_dir/include"
    #add_dir_to_linker_path "$component_dir/lib"
    #add_dir_to_pkg_config_path "$component_dir/lib/pkgconfig"

    # Setup MacVim environment variables
    add_dir_to_path "/Applications/MacVim.app/Contents/bin"

    # Add Visual Studio Code (code)
    add_dir_to_path_end "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
elif [[ "$(uname -s)" == "Linux" ]] then
    if [[ -d "/usr/lib/jvm/java-11-openjdk-amd64" ]] then
        # Setup JAVA environment variables
        export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
        add_dir_to_path "$JAVA_HOME/bin"
    fi

    # Add snap bin directory in case zsh isn't picking it up via the standard /etc/profile.d/apps-bin-path.sh
    add_dir_to_path "/snap/bin"

    # Add ruby include, linker and pkg_config_path (I think there must be a better way)
    add_dir_to_path "$HOME/.gem/ruby/2.7.0/bin"
    add_dir_to_include_path "/usr/include/ruby-2.7.0"
    add_dir_to_include_path "/usr/include/x86_64-linux-gnu/ruby-2.7.0"
    add_dir_to_linker_path "/usr/lib/x86_64-linux-gnu/ruby/2.7.0"
    add_dir_to_pkg_config_path "/usr/lib/x86_64-linux-gnu/pkgconfig"
fi

# Setup pyenv environment
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Setup the pyenv-virtualenv environment
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Create the ~/.zsh_functions directory for user defined zsh command completions
[ ! -d "$HOME/.zsh_functions" ] && mkdir "$HOME/.zsh_functions"
add_dir_to_fpath "$HOME/.zsh_functions"

# set the various application environment variables
set_env_variable_from_list "EDITOR" "mvim" "vim" "mate" "code" "vi" "nano"
set_env_variable_from_list "VISUAL" "mvim" "gvim" "mate" "code" "vim" "vi" "nano"

if command -v brew &>/dev/null; then
    export HOMEBREW_NO_AUTO_UPDATE=1
    set_env_variable_from_list "HOMEBREW_EDITOR" "mvim" "vim" "mate" "code" "vi" "nano"
    if command -v bat &>/dev/null; then
        export HOMEBREW_BAT=1
        export HOMEBREW_BAT_CONFIG_PATH=$HOME/.config/bat/config
    fi
fi

# for macOS this alias is set in .zsh_aliases and Linux it is what the Chrome binary is called
[ -n "$DISPLAY" ] && export BROWSER=google-chrome

export TMPDIR=${TMPDIR:-"/tmp"}
export TMP=${TMP:-"/tmp"}
export PAGER="less -RFX"
export MAN_PAGER="less -RFX"
export BAT_PAGER="less -RFX"

# Setup perlbrew environment variables
export PERLBREW_ROOT=$HOME/perl5/perlbrew
export PERLBREW_HOME=$HOME/.perlbrew

#
# Create the LS_COLORS environment variable using the 'vivid' applilcation
# Oh Ubuntu `apt` will install filetypes.yml to /usr/share/vivid and themees (*.yml) to /usr/share/vivid/themes
# If `cargo install vivid` was used instead these directories where not created
# On Ubuntu: mkdir -p /usr/share/vivid/themes
#            cp $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/config/filetypes.yml /usr/share/vivid
#            cp $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/themes/*.yml /usr/share/vivid/themes
# On macOS:  mkdir -p /usr/local/share/vivid/themes
#            cp $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/config/filetypes.yml /usr/local/share/vivid
#            cp $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/themes/*.yml /usr/local/share/vivid/themes
# This enables Ubuntu to work without any configuration. But since macOS is using a different than expected directory,
#  you have to use the `VIVID_DATABASE=/usr/local/share/vivid/filetypes.yml` environment variable. But that doesn't seem
#  to fix every problem either.
# The best solution, until there is clear support on all platforms, is to place the above files in `$HOME/.config/vivid`.
#   The `vivid` code supports the $HOME/.config/vivid directory out-of-the-box, no extra ENV or switches needed.
#   Then it's just a matter of keeping the files updated every time vivid is released.  On all platforms:
#   cp -vi $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/config/filetypes.yml $HOME/.config/vivid
#   cp -vi $HOME/.cargo/registry/src/github.com-1ecc6299db9ec823/vivid-0.5.0/themes/*.yml $HOME/.config/vivid/themes
#

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Vivid has a number of builtin themese. List them by calling:
#  `vivid themese`
# It is also able to show a preview of each listed theme:
#  `vivid preview <theme-name>` e.g. `vivid preview solarized-light`
# Here are my recommendations:
# [     ] ayu
# [     ] dracula
# [     ] gruvbox-dark
# [     ] gruvbox-dark-hard
# [     ] gruvbox-dark-soft
# [     ] gruvbox-light
# [     ] gruvbox-light-hard
# [     ] gruvbox-light-soft
# [     ] iceberg-dark
# [   **] jellybeans
# [    *] lava
# [    *] molokai
# [     ] nord
# [   **] one-dark
# [  ***] one-light
# [ ****] snazzy
# [     ] solarized-dark
# [     ] solarized-light
if command -v vivid &>/dev/null; then
    export LS_COLORS="$(vivid generate snazzy)"
    export EXA_COLORS="$(vivid generate snazzy)"
fi

# Set the location for the SCREENRC config file
[ -e "$HOME/.config/screen/.screenrc" ] && export SCREENRC=$HOME/.config/screen/.screenrc

# RipGrep needs to know where its configuration file is located
[ -e "$HOME/.config/ripgrep/.ripgreprc" ] && export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc

# Setup golang environment variables
if [[ -d "/usr/local/go" ]] then
    export GOROOT=/usr/local/go
    [ -z "${GOPATH+x}" ] && export GOPATH="$HOME/go"
    mkdir -p "$GOPATH/bin"
    add_dir_to_path "$GOPATH/bin"
    add_dir_to_path "$GOROOT/bin"
fi

# Add the environment variable which speciifies where the cheat sheet configuration file is located
if [[ -e "$HOME/.config/cht.sh/cht.sh.conf" ]] then
    export CHTSH_CONF="$HOME/.config/cht.sh/cht.sh.conf"
fi

# Ensure that the TCL interpretter can find the expect library
#if [[ $TCLLIBPATH && ${TCLLIBPATH-x} ]] then
#    export TCLLIBPATH="$TCLLIBPATH /usr/local/lib"
#else
#    export TCLLIBPATH="/usr/local/lib"
#fi

add_dir_to_fpath "${ZSH_CUSTOM:-${ZSH:-${HOME}/.oh-my-zsh}/custom}/plugins/zsh-completions/src"

# Make all the paths unique
typeset -xTU PATH path ':'
typeset -TU FPATH fpath ':'
typeset -xTU PKG_CONFIG_PATH pkg_config_path ':'
typeset -xTU CXXFLAGS cxxflags ' '
typeset -xTU CFLAGS cflags ' '
typeset -xTU LDFLAGS ldflags ' '
typeset -xTU TCLLIBPATH tcllibpath ' '

# Initialize the ZSH completion system
autoload -Uz compinit && compinit

# Case insensitive ZSH path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}{[:upper:][:lower:]}' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]}l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Partial ZSH completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Load ZSH bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

# Finally, clean-up the environment before leaving
unfunction add_dir_to_path
unfunction add_dir_to_fpath
unfunction add_dir_to_pkg_config_path
unfunction add_dir_to_include_path
unfunction add_to_linker_environment_variable
unfunction add_dir_to_linker_path

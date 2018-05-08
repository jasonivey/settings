# .bash_profile
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

# Custom Jason Ivey settings
source $HOME/settings/.bash_settings

# Ruby
export PATH="$HOME/.rbenv/shims:$PATH"

# Adobe DW BuildRunner
export PATH="$HOME/dev/buildrunner/scripts:$PATH"

# Adobe dvm build tool
export PATH="$HOME/dev/devmode/target/release:$PATH"

# Rust compiler and tools
export PATH="$HOME/.cargo/bin:$PATH"

# Latest LLVM and clang compiler tools
export PATH="/usr/local/opt/llvm/bin:$PATH"

# for use with the GO language installation
export PATH="/usr/local/go/bin:$PATH"
export GOROOT="/usr/local/go"
export GOPATH="$HOME/scripts/go"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

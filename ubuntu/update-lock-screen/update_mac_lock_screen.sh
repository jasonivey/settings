#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

export HOME={HOME:-/Users/jasoni}
hash fortune &> /dev/null
if [ $? -ne 0 ]; then
    export PATH="/Users/jasoni/.opam/default/bin:/usr/local/opt/tcl-tk/bin:/usr/local/opt/ruby/bin:/Users/jasoni/perl5/bin:/Users/jasoni/.nix-profile/bin:/Users/jasoni/go/bin:/Applications/MacVim.app/Contents/bin:/Users/jasoni/Library/Python/3.7/bin:/usr/local/opt/ruby/bin:/usr/local/opt/gnu-getopt/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/unzip/bin:/usr/local/opt/llvm/bin:/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands:/Users/jasoni/perl5/perlbrew/bin:/Users/jasoni/perl5/perlbrew/perls/perl-5.28.0/bin:/Users/jasoni/.cargo/bin:/Users/jasoni/.local/bin:/Users/jasoni/scripts:/usr/local/bin:/usr/local/sbin:/Users/jasoni/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin::/usr/local/go/bin:/opt/X11/bin:/Library/Apple/usr/bin:.:$PATH"
fi

while :
do
    text=$(fortune softwareengineering)
    sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "$text" >& /dev/null
    if [ $? -eq 0 ]; then
        sudo diskutil apfs updatePreboot / >& /dev/null
        break
    fi
done


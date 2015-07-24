#!/usr/bin/env bash

pushd `pwd` > /dev/null
cd ~/.vim/bundle/clang_complete
make clean
make
vim clang_complete.vmb -c 'so %' -c 'q'
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd > /dev/null


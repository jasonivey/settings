#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e
PWD=`dirname $0`
cd $PWD
DIR=`pwd`

sudo apt-get update
sudo apt-get -y install \
    build-essential \
    cmake \
    cscope \
    curl \
    exuberant-ctags \
    gettext \
    git \
    git-core \
    libncurses5-dev \
    libpcre3 \
    libpcre3-dev \
    libperl-dev \
    lua5.2 \
    perl \
    python-dev \
    python3-dev \
    python-software-properties \
    ruby \
    ruby-dev \
    tk8.5 \
    tcl8.5 \
    tcl8.5-dev \
    yasm

mkdir -p /tmp/dev-tools/
cd /tmp/dev-tools/
git clone https://github.com/vim/vim.git
cd vim
if [ -n "$1" ]; then
    git co $1
fi

./configure --with-features=huge \
    --with-compiledby="Jason Ivey" \
    --enable-luainterp \
    --enable-perlinterp \
    --enable-pythoninterp \
    --enable-python3interp \
    --with-tclsh=tclsh8.5 \
    --enable-tclinterp \
    --enable-rubyinterp \
    --enable-cscope

make

# sudo make install

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
    lua5.3 \
    perl \
    python2.7
    python2.7-dev \
    python2.7-doc \
    python3.7
    python3.7-dev \
    python3.7-doc \
    software-properties-common \
    ruby \
    ruby-dev \
    tk8.6 \
    tcl8.6 \
    tcl8.6-dev \
    yasm

# Create the install destination and change the ownership to this user
sudo mkdir -p /opt/vim/
sudo chown $USER:$USER /opt/vim/

# Create the build location to somewhere where it will be deleted
mkdir -p /tmp/dev-tools/
cd /tmp/dev-tools/

# Clone only one level deep -- for vim this usually includes 1 release tag
git clone --depth 1 https://github.com/vim/vim.git vim
cd vim
if [ -n "$1" ]; then
    git co $1
fi

./configure --with-features=huge \
    --prefix=/opt/vim/bin \
    --mandir=/opt/vim/share/man \
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
make install

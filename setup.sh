#!/usr/bin/env bash

PWD=`dirname $0`
cd $PWD
DIR=`pwd`

#allow sudoless password
SUDOSTR=
if ! sudo grep -q "$USER.*NOPASSWD:ALL" /etc/sudoers
then
    sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
fi

files=".bash_profile
.gdbinit
.gitconfig
.tmux.conf
.vimrc
.vim"

for f in $files
do
    ln -fsn $DIR/$f ~/$f
done

sudo apt-get install openssh-server \
    git \
    git-core \
    mercurial \
    build-essential \
    clang-3.5 \
    clang-format-3.5 \
    pkg-config \
    libcppunit-dev \
    yasm \
    libboost-all-dev \
    libbz2-dev \
    cmake \
    curl \
    perl \
    libperl-dev \
    lua5.2 \
    liblua5.2-0 \
    liblua5.2-0-dbg \
    liblua5.2-dev \
    libssl-dev \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python-dev \
    ruby-dev \
    zlib1g-dev \
    libreadline6 \
    libreadline6-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    python-software-properties \
    libffi-dev \
    dos2unix

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle

if [ ! -d "vundle" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git vundle
fi

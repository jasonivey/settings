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

files=".bash_aliases
.dircolors
.gdbinit
.gitconfig
.tmux.conf
.vimrc"

for f in $files
do
    ln -fsn $DIR/$f ~/$f
done

sudo apt-get install python-software-properties

if [ "$(lsb_release -sc)" == "precise" ]; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
fi

echo "deb http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.5 main"     | sudo tee    /etc/apt/sources.list.d/llvm.list
echo "deb-src http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.5 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
echo "deb http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.7 main"     | sudo tee -a /etc/apt/sources.list.d/llvm.list
echo "deb-src http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-3.7 main" | sudo tee -a /etc/apt/sources.list.d/llvm.list
echo "deb http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)" main"         | sudo tee -a /etc/apt/sources.list.d/llvm.list
echo "deb-src http://llvm.org/apt/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)" main"     | sudo tee -a /etc/apt/sources.list.d/llvm.list

wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key |sudo apt-key add -

sudo apt-get update

sudo apt-get install openssh-server \
    cscope \
    silversearcher-ag \
    git \
    git-core \
    mercurial \
    build-essential \
    clang-3.5 \
    clang-format-3.5 \
    clang-3.7 \
    clang-format-3.7 \
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

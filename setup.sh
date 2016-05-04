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

files=".bash_aliases .dircolors .gdbinit .gitconfig .tmux.conf .vimrc"

for f in $files
do
    ln -fsn $DIR/$f $HOME/$f
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

sudo apt-get install \
    build-essential \
    clang-3.7 \
    clang-format-3.7 \
    cmake \
    cscope \
    curl \
    dos2unix \
    git \
    git-core \
    htop \
    libatk1.0-dev \
    libbonoboui2-dev \
    libboost-all-dev \
    libbz2-dev \
    libcairo2-dev \
    libcppunit-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    liblua5.2-0 \
    liblua5.2-0-dbg \
    liblua5.2-dev \
    libncurses5-dev \
    libperl-dev \
    libreadline6 \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libx11-dev \
    libxml2-dev \
    libxpm-dev \
    libxslt1-dev \
    libxt-dev \
    libyaml-dev \
    lua5.2 \
    mercurial \
    openssh-server \
    perl \
    pkg-config \
    python-dev \
    python-software-properties \
    ruby \
    ruby-dev \
    silversearcher-ag \
    sqlite3 \
    unzip \
    yasm \
    zip \
    zlib1g \
    zlib1g-dev \
    zlibc \

mkdir -p $HOME/.config/htop
ln -fsn $DIR/htoprc $HOME/.config/htop/htoprc

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle

if [ ! -d "vundle" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git vundle
fi

source $HOME/settings/setup_vim.sh


#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

PWD=`dirname $0`
cd $PWD
DIR=`pwd`

#allow sudoless password
SUDOSTR=
if ! sudo grep -q "$USER.*NOPASSWD:ALL" /etc/sudoers
then
    sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
fi

files=".bash_aliases .dircolors .gdbinit .gitconfig .i2csshrc .tmux.conf .vimrc"

for f in $files
do
    ln -fsn $DIR/$f $HOME/$f
done

sudo apt-get install python-software-properties

if [ "$(lsb_release -sc)" == "precise" ]; then
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
fi

wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -

# GCC Adding GCC-6
sudo add-apt-repository ppa:ubuntu-toolchain-r/test

# Repo for clang-4.0
sudo apt-add-repository "deb http://apt.llvm.org/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-4.0 main"

sudo apt-get update

sudo apt-get install \
    bash-completion \
    build-essential \
    clang-3.7 \
    clang-format-3.7 \
    cmake \
    cowsay \
    cscope \
    curl \
    dos2unix \
    exuberant-ctags \
    filters \
    fortune \
    fortunes \
    fortunes-off \
    gcc-6 \
    g++-6 \
    git \
    git-core \
    golang-go \
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
    libgtest-dev \
    libgtk2.0-dev \
    libjsoncpp-dev \
    libjsoncpp1 \
    liblua5.2-0 \
    liblua5.2-0-dbg \
    liblua5.2-dev \
    libncurses5-dev \
    libperl-dev \
    libreadline6 \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libssl-doc \
    libx11-dev \
    libxml2-dev \
    libxpm-dev \
    libxslt1-dev \
    libxt-dev \
    libyaml-dev \
    lolcat \
    lua5.2 \
    mercurial \
    openssh-server \
    openssl \
    perl \
    pkg-config \
    python-dev \
    python3-dev \
    python-pip \
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

sudo pip install --upgrade pip
sudo pip install thefuck

mkdir -p $HOME/.config/htop
ln -fsn $DIR/htoprc $HOME/.config/htop/htoprc

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle

if [ ! -d "vundle" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git vundle
fi

source $HOME/settings/setup_vim.sh


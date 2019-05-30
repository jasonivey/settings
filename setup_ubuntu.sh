!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

#sudo apt-get install python-software-properties

#if [ "$(lsb_release -sc)" == "precise" ]; then
#    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
#fi

# Add the LLVM repo gpg key
#wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -

# GCC Adding GCC-6
#sudo add-apt-repository ppa:ubuntu-toolchain-r/test

# Repo for clang-4.0
# sudo apt-add-repository "deb http://apt.llvm.org/"$(lsb_release -sc)"/ llvm-toolchain-"$(lsb_release -sc)"-7.0 main"

# sudo apt-get update

sudo apt-get install \
    bash-completion \
    build-essential \
    cmake \
    cowsay \
    cscope \
    curl \
    dos2unix \
    exuberant-ctags \
    filters \
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
    libgtest-dev \
    libgtk2.0-dev \
    libjsoncpp-dev \
    libjsoncpp1 \
    liblua5.2-0 \
    liblua5.2-0-dbg \
    liblua5.2-dev \
    libncurses5-dev \
    libperl-dev \
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

#source $HOME/settings/setup_ubuntu_vim.sh


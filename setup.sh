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

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle

if [ ! -d "vundle" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git vundle
fi

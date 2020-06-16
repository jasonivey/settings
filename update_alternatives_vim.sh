#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

set -e

echo -e "\e[31mCreating links to the existing vim binaries\e[0m"

sudo update-alternatives --install /usr/bin/editor   editor   /opt/vim/bin/vim      1500
sudo update-alternatives --install /usr/bin/eview    eview    /opt/vim/bin/eview    1500
sudo update-alternatives --install /usr/bin/evim     evim     /opt/vim/bin/evim     1500
sudo update-alternatives --install /usr/bin/ex       ex       /opt/vim/bin/ex       1500
sudo update-alternatives --install /usr/bin/gview    gview    /opt/vim/bin/gview    1500
sudo update-alternatives --install /usr/bin/gvim     gvim     /opt/vim/bin/gvim     1500
sudo update-alternatives --install /usr/bin/gvimdiff gvimdiff /opt/vim/bin/gvimdiff 1500
sudo update-alternatives --install /usr/bin/rgview   rgview   /opt/vim/bin/rgview   1500
sudo update-alternatives --install /usr/bin/rgvim    rgvim    /opt/vim/bin/rgvim    1500
sudo update-alternatives --install /usr/bin/rview    rview    /opt/vim/bin/rview    1500
sudo update-alternatives --install /usr/bin/rvim     rvim     /opt/vim/bin/rvim     1500
sudo update-alternatives --install /usr/bin/vi       vi       /opt/vim/bin/vim      1500
sudo update-alternatives --install /usr/bin/view     view     /opt/vim/bin/view     1500
sudo update-alternatives --install /usr/bin/vim      vim      /opt/vim/bin/vim      1500
sudo update-alternatives --install /usr/bin/vimdiff  vimdiff  /opt/vim/bin/vimdiff  1500

echo -e "\e[31mCreated all links to the existing vim binaries\e[0m"

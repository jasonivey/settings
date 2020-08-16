#!/usr/bin/env bash
# vim: awa:sts=4:ts=4:sw=4:et:cin:fdm=manual:tw=120:ft=bash

set -e

#echo -e "\e[32mDeleting liks from pervious (wrong location) vim binaries\e[0m"

#sudo update-alternatives --remove editor   /opt/vim/bin/vim
#sudo update-alternatives --remove eview    /opt/vim/bin/eview
#sudo update-alternatives --remove evim     /opt/vim/bin/evim
#sudo update-alternatives --remove ex       /opt/vim/bin/ex
#sudo update-alternatives --remove gview    /opt/vim/bin/gview
#sudo update-alternatives --remove gvim     /opt/vim/bin/gvim
#sudo update-alternatives --remove gvimdiff /opt/vim/bin/gvimdiff
#sudo update-alternatives --remove rgview   /opt/vim/bin/rgview
#sudo update-alternatives --remove rgvim    /opt/vim/bin/rgvim
#sudo update-alternatives --remove rview    /opt/vim/bin/rview
#sudo update-alternatives --remove rvim     /opt/vim/bin/rvim
#sudo update-alternatives --remove vi       /opt/vim/bin/vim
#sudo update-alternatives --remove view     /opt/vim/bin/view
#sudo update-alternatives --remove vim      /opt/vim/bin/vim
#sudo update-alternatives --remove vimdiff  /opt/vim/bin/vimdiff

echo -e "\e[32mCreating links to the existing vim binaries\e[0m"

[ -e "/usr/local/bin/vim" ]      && sudo update-alternatives --install /usr/bin/editor   editor   /usr/local/bin/vim      1500
[ -e "/usr/local/bin/eview" ]    && sudo update-alternatives --install /usr/bin/eview    eview    /usr/local/bin/eview    1500
[ -e "/usr/local/bin/evim" ]     && sudo update-alternatives --install /usr/bin/evim     evim     /usr/local/bin/evim     1500
[ -e "/usr/local/bin/ex" ]       && sudo update-alternatives --install /usr/bin/ex       ex       /usr/local/bin/ex       1500
[ -e "/usr/local/bin/gview" ]    && sudo update-alternatives --install /usr/bin/gview    gview    /usr/local/bin/gview    1500
[ -e "/usr/local/bin/gvim" ]     && sudo update-alternatives --install /usr/bin/gvim     gvim     /usr/local/bin/gvim     1500
[ -e "/usr/local/bin/gvimdiff" ] && sudo update-alternatives --install /usr/bin/gvimdiff gvimdiff /usr/local/bin/gvimdiff 1500
[ -e "/usr/local/bin/rgiew" ]    && sudo update-alternatives --install /usr/bin/rgview   rgview   /usr/local/bin/rgview   1500
[ -e "/usr/local/bin/rgvim" ]    && sudo update-alternatives --install /usr/bin/rgvim    rgvim    /usr/local/bin/rgvim    1500
[ -e "/usr/local/bin/rview" ]    && sudo update-alternatives --install /usr/bin/rview    rview    /usr/local/bin/rview    1500
[ -e "/usr/local/bin/rvim" ]     && sudo update-alternatives --install /usr/bin/rvim     rvim     /usr/local/bin/rvim     1500
[ -e "/usr/local/bin/vi" ]       && sudo update-alternatives --install /usr/bin/vi       vi       /usr/local/bin/vim      1500
[ -e "/usr/local/bin/view" ]     && sudo update-alternatives --install /usr/bin/view     view     /usr/local/bin/view     1500
[ -e "/usr/local/bin/vim" ]      && sudo update-alternatives --install /usr/bin/vim      vim      /usr/local/bin/vim      1500
[ -e "/usr/local/bin/vimdiff" ]  && sudo update-alternatives --install /usr/bin/vimdiff  vimdiff  /usr/local/bin/vimdiff  1500

echo -e "\e[32mCreated all links to the existing vim binaries\e[0m"

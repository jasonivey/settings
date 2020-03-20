#!/usr/bin/env bash
# vim:softtabstop=4:ts=4:sw=4:expandtab:tw=120

set -e

echo Creating links to the existing vim binaries
update-alternatives --install /usr/bin/editor   editor   /opt/vim/bin/vim      1500
update-alternatives --install /usr/bin/eview    eview    /opt/vim/bin/eview    1500
update-alternatives --install /usr/bin/evim     evim     /opt/vim/bin/evim     1500
update-alternatives --install /usr/bin/ex       ex       /opt/vim/bin/ex       1500
update-alternatives --install /usr/bin/gview    gview    /opt/vim/bin/gview    1500
update-alternatives --install /usr/bin/gvim     gvim     /opt/vim/bin/gvim     1500
update-alternatives --install /usr/bin/gvimdiff gvimdiff /opt/vim/bin/gvimdiff 1500
update-alternatives --install /usr/bin/rgview   rgview   /opt/vim/bin/rgview   1500
update-alternatives --install /usr/bin/rgvim    rgvim    /opt/vim/bin/rgvim    1500
update-alternatives --install /usr/bin/rview    rview    /opt/vim/bin/rview    1500
update-alternatives --install /usr/bin/rvim     rvim     /opt/vim/bin/rvim     1500
update-alternatives --install /usr/bin/vi       vi       /opt/vim/bin/vim      1500
update-alternatives --install /usr/bin/view     view     /opt/vim/bin/view     1500
update-alternatives --install /usr/bin/vim      vim      /opt/vim/bin/vim      1500
update-alternatives --install /usr/bin/vimdiff  vimdiff  /opt/vim/bin/vimdiff  1500
echo Created all links to the existing vim binaries
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

files=".bash_aliases .dircolors .gdbinit .gitconfig .i2csshrc .msmtprc .transmission-remote-cli.config .tmux.conf .screenrc .vimrc .ripgreprc"

for f in $files
do
    ln -fsn $DIR/$f $HOME/$f
done

# make neovim and vim have the current same settings
ln -fsn $DIR/.vimrc $HOME/.config/nvim/init.vim

# add the latest git_completion even though git probably isn't on the system yet
curl -o $HOME/settings/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > /dev/null 2>&1

mkdir -p $HOME/.config/powerline
mkdir -p $HOME/.config/htop
ln -fsn $DIR/htoprc $HOME/.config/htop/htoprc

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle

if [ ! -d "vundle" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

if [ "$(uname)" == "Darwin" ]; then
    . $HOME/settings/setup_mac.sh
elif [ "$(uname -s)" == "Linux" ]; then
    . $HOME/settings/setup_ubuntu.sh
fi

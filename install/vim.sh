#!/bin/bash

sudo apt install python-dev python3-dev libncurses5-dev libncursesw5-dev libx11-dev libxtst-dev xorg-dev -yqq
mkdir -p $HOME/src/vim
git clone https://github.com/vim/vim --depth=1 $HOME/src/vim
cd $HOME/src/vim
sudo ./configure \
            --enable-multibyte \
            --enable-fontset \
            --enable-xim \
            --enable-gui=auto \
            --enable-luainterp=yes \
            --enable-pythoninterp=yes \
            --enable-rubyinterp=yes \
            --enable-perlinterp \
            --enable-cscope \
            --enable-sniff \
            --with-x \
            --with-compiledby=erocpil \
            --with-features=huge \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-localmap \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
            --enable-gtk-check \
            --enable-gui=gtk2 \
            --prefix=/usr/local

make -j8
sudo make install

cd ..

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +GoInstallBinaries +qa
cd $HOME/.vim/bundle/YouCompleteMe
./install.py --js-completer --go-completer
cd $HOME/dotfiles
cp -r UltiSnips $HOME/.vim

#!/bin/bash

if ( [ ! -x "$(command -v vim)" ] || ! (( $( vim --version | grep -c "+python3") ))  );
then
# have to build from source for YouCompleteMe to work
VIM_DIR=$ZETUP_USE_PKG/build/src/vim
mkdir -p $VIM_DIR
git clone https://github.com/vim/vim --depth=1 $VIM_DIR
cd $VIM_DIR
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

# ultisnips
cp -r "$ZETUP_SUB_PKG_DIR/UltiSnips" "$HOME/.vim"

# you complete me
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +GoInstallBinaries +qa
cd $HOME/.vim/bundle/YouCompleteMe
./install.py --js-completer --go-completer
fi

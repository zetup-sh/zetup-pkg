#!/bin/bash

PY2_CONFIG_DIR=$(sudo find /usr/lib -type d -regex ".*python2.[0-9]/config[^/]*")
PY3_CONFIG_DIR=$(sudo find /usr/lib -type d -regex ".*python3.[0-9]/config[^/]*")

if ( [ -d "$PY2_CONFIG_DIR" ] || [ -d "$PY3_CONFIG_DIR" ] ) ; then
  py2_arg="--with-python-config-dir=$PY2_CONFIG_DIR"
  py3_arg="--with-python3-config-dir=$PY3_CONFIG_DIR"
fi

if ( [ ! -x "$(command -v vim)" ] || ! (( $( vim --version | grep -c "+python3") ))  ); then
# have to build from source for YouCompleteMe to work
VIM_DIR=$ZETUP_CUR_PKG/build/src/vim
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
  "$py2_arg" \
  "$py3_arg" \
  --enable-localmap \
  --enable-python3interp=yes \
  --enable-gtk-check \
  --enable-gui=gtk2 \
  --prefix=/usr/local

make -j8
sudo make install

# UltiSnips
cp -r "$ZETUP_CUR_PKG/subpkg/vim/UltiSnips" "$HOME/.vim"

# YouCompleteMe
if ( [ -d "$PY2_CONFIG_DIR" ] || [ -d "$PY3_CONFIG_DIR" ] ) ; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +GoInstallBinaries +qa
  cd $HOME/.vim/bundle/YouCompleteMe
  ./install.py --js-completer --go-completer
fi
fi
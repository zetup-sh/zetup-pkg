#!/bin/bash

eval `zetup env`

for f in "$ZETUP_CUR_PKG"/subpkg/*/bashrc.sh
do
  source "$f"
done

bin_path="$ZETUP_CUR_PKG/bin"
export PATH="$PATH:$bin_path"
export PATH="$PATH:$bin_path/tmux"
export PATH="$PATH:$bin_path/git"

. $HOME/.aliases
. $HOME/.fns

export PATH=$PATH:/usr/sbin
export PATH=$PATH:$ZETUP_BIN

export EDITOR=vim
export HISTSIZE=50000
export HISTFILESIZE=100000

if [ -f $HOME/.dir_colors/dircolors ]
  then eval `dircolors ~/.dir_colors/dircolors`
fi

# go to the dev directory
if [[ $HOME == "$(pwd)" ]]; then cd $HOME/dev ; fi
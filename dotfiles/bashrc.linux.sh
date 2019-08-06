eval `zetup env`

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

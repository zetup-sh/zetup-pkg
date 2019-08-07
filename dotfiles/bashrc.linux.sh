eval `zetup env`

# temporary for development
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go
# end temporary

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

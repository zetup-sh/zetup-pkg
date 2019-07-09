export PATH=$PATH:/usr/sbin:$HOME/zetup/bin
PATH=$PATH:$( find $HOME/zetup/bin/ -type d -printf ":%p" )
export PATH=$PATH:$HOME/.npm/bin:$HOME/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use 12.4.0 --silent


export PATH=$PATH:/usr/lib/go-1.10/bin::$HOME/.bin
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$PATH:/opt/yarn-0.22.0/bin"
export EDITOR=vim
export HISTSIZE=50000
export HISTFILESIZE=100000
export NODEBASHVIM=$HOME/node-bash/vim

alias "ls=ls --color=auto"
if [ -f ~/.dir_colors/dircolors ]
  then eval `dircolors ~/.dir_colors/dircolors`
fi

if [ -x "$(command -v docker-machine)" ]; then
  source /etc/bash_completion.d/docker-machine-prompt.bash;
  PS1='${PWD##*/} $(__docker_machine_ps1 " [%s]")$ ';
fi

if [[ $HOME == "$(pwd)" ]]; then cd $HOME/dev ; fi

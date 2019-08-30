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
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
SSH_ENV="$HOME/.ssh/environment"

# start ssh agent if it's not already started (necessary when you ssh tunnel)
function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent;
  }
  ssh-add "$ZETUP_PRIVATE_KEY_FILE"
else
  start_agent;
fi

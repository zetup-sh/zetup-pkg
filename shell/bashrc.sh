#!/bin/bash

export PATH="$PATH:$HOME/go/bin"
eval `zetup env`

# let bashrc function normally if they just deleted
# zetup without uninstalling
if [ -n "$ZETUP_CUR_PKG" ] && [ -x "$(command -v zetup)" ]; then
  for f in "$ZETUP_CUR_PKG"/subpkg/*/bashrc.sh; do
    . "$f"
  done
  bin_path="$ZETUP_CUR_PKG/bin"
  export PATH="$PATH:$bin_path"
  export PATH="$PATH:$bin_path/tmux"
  export PATH="$PATH:$bin_path/git"
fi


. $HOME/.aliases
. $HOME/.fns

export PATH=$PATH:/usr/sbin
export HISTSIZE=50000
export HISTFILESIZE=100000

if [ -f $HOME/.dir_colors/dircolors ]
  then eval `dircolors ~/.dir_colors/dircolors`
fi

# go to the dev directory
[ $HOME == "$(pwd)" ] && cd $HOME/dev
SSH_ENV="$HOME/.ssh/environment"

# start ssh agent if it's not already started (necessary when you ssh tunnel)
function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add >/dev/null 2>&1
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent
    ssh-add "$ZETUP_PRIVATE_KEY_FILE" > /dev/null 2>&1
  }
elif [ -z "${SSH_AGENT_PID}" ]; then
  start_agent
  ssh-add "$ZETUP_PRIVATE_KEY_FILE" >/dev/null 2>&1
fi
eval `ssh-agent`
ssh-add $HOME/.ssh/zetup_id_rsa

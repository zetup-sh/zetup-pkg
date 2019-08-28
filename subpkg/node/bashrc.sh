#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
nvm use 12.4.0 --silent

export PATH="$PATH:$HOME/.npm/bin"
export PATH="$PATH:$HOME/.local/bin"

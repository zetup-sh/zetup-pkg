#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use 12.4.0 --silent

export PATH="$PATH:$(yarn global bin)/bin"
export PATH="$PATH:$HOME/.npm/bin"
export PATH="$PATH:$HOME/.local/bin"

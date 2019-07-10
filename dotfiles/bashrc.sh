export DOTDIR="$HOME/zetup/dotfiles"
export OVERRIDEDIR="$HOME/zetup/override"
export CUSTOMDIR="$HOME/zetup/custom"
for i in bashrc.sh aliases.sh fns.sh ;
  do
    if [ -f "$OVERRIDEDIR/$i" ] ;
      then source "$OVERRIDEDIR/$i" ;
      else source "$DOTDIR/_$i" ;
    fi
    if [ -f "$CUSTOMDIR/$i" ] ; then source "$CUSTOMDIR/$i" ; fi
  done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#!/bin/bash

for i in ~/zetup/dotfiles/*;
do
  bn=$(basename $i) ;
  if [[ ! "$bn" = _* ]] ;
    then
      dotname="$HOME/.${bn%%.*}"
      if [ -f "$dotname" ];
	then
          mv "$dotname" "$dotname.bak"
          ln -s "$i" "$dotname"
      fi
   fi
done


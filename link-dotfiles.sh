#!/bin/bash

for i in ~/zetup/dotfiles/*;
do
  bn=$(basename $i) ;
  if [[ ! "$bn" = _* ]] ;
    then
      dotname="$HOME/.$bn"
      if [ -f "$dotname" ];
	then
          mv "$dotname" "$dotname.bak"
      fi
      echo $dotname
      ln -s "$i" "$dotname"
   fi
done


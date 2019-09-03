#!/bin/bash

# add gh/gl to known hosts
ssh-keygen -F github.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null

ssh-keygen -F gitlab.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null

git_completion_location="$HOME/git-completion.bash"
if [ ! -f "${git_completion_location}" ]; then
  curl -L "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" -o "${git_completion_location}"
fi

ssh-add $ZETUP_PRIVATE_KEY_FILE >/dev/null 2>&1

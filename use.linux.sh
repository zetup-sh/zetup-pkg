#!/bin/bash

# this file will be run whenever a use types `zetup use [this package name]`
# It's automatically recognized as a linux/darwin file because of its `.sh` extension
# It's recognized as exclusively linux because of its `-linux` suffix

# add gh/gl to known hosts
ssh-keygen -F github.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null

ssh-keygen -F gitlab.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null
exit 0

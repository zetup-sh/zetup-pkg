#!/bin/bash

# add gh/gl to known hosts
ssh-keygen -F github.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null

ssh-keygen -F gitlab.com >/dev/null
(($? != 0)) && ssh-keyscan -H gitlab.com >> $HOME/.ssh/known_hosts 2>/dev/null
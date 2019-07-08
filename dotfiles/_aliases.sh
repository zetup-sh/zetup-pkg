#!/usr/local/bin bash
alias showip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias setconf="export KUBECONFIG=$HOME/go/src/gitlab.com/zwhitchcox/serfsage/kubeconfig"
alias setpdt="sudo ln -fs /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime"
alias setest="sudo ln -fs /usr/share/zoneinfo/Etc/GMT+5 /etc/localtime"
alias vi=vim
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~/dev"
alias ~go="cd ~/go/src/gitlab.com/$username"

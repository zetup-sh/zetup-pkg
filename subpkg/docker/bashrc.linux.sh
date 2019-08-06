#!/bin/bash
alias docker-stop-all-containers="docker stop \$(docker container ls -aq) && docker rm \$(docker container ls -aq)"
alias docker-machine-unset="eval \\$(docker-machine env -u)"

if [ -x "$(command -v docker-machine)" ]; then
  source /etc/bash_completion.d/docker-machine-prompt.bash;
  PS1='${PWD##*/} $(__docker_machine_ps1 " [%s]")$ ';
fi

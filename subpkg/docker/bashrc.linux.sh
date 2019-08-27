#!/bin/bash
alias docker-stop-all-containers="docker stop \$(docker container ls -aq) && docker rm \$(docker container ls -aq)"
alias docker-machine-unset="eval \\$(docker-machine env -u)"

dm_prompt_file="/etc/bash_completion.d/docker-machine-prompt.bash"
if [ -f "$dm_prompt_file" ]; then
  source $dm_prompt_file;
  PS1='${PWD##*/} $(__docker_machine_ps1 " [%s]")$ ';
fi

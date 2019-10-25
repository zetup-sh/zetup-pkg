#!/bin/bash

# install docker if not already installed
if [ ! -x "$(command -v docker)" ] ; then
  if [ -x "$(command -v apt-get)" ] ; then
    echo apt-get exists
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get -y install docker-ce
    sudo systemctl enable docker
    sudo setfacl -m $USER:rw /var/run/docker.sock
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo systemctl start docker
  else
    snap_install docker
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo setfacl -m $USER:rw /var/run/docker.sock
  fi
fi

# install docker-compose if not already installed
if [ ! -x "$(command -v docker-compose)" ] ; then
  sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi


# install docker-machine if not already installed
if [ ! -x "$(command -v docker-machine)" ] ; then
  base=https://github.com/docker/machine/releases/download/v0.16.0 &&
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
    sudo install /tmp/docker-machine /usr/local/bin/docker-machine
fi
if [ ! -f "/etc/bash_completion.d/docker-machine-prompt.bash" ] ; then
  base=https://raw.githubusercontent.com/docker/machine/v0.16.0
  for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash ; do
    sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
  done
fi


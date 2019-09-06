# zetup

### Requirements

OS X: version 10.9 or higher

### To Run

`wget https://github.com/zwhitchcox/zetup/raw/public/init.sh && source init.sh`

OR

`curl https://github.com/zwhitchcox/zetup/raw/public/init.sh && source init.sh`


## What is this?

These are files I want to use every time I move to a new machine (ubuntu & (windows coming soon)).

If you run the above setup script, it prompts you for your username, email, and name and then installs many basic utilities (see ./init.sh) and then clones this repository and installs many development programs I use including the following:

### Development Tools

* docker
  - docker-compose
  - docker-machine
  - virtualbox)
* go
  - creates source directories
  - adds `go` to your path
* kubernetes
  - minikube
* node
  - yarn
  - nvm (with latest node)
  - globally: nodemon, typescript, webpack, jest, pm2 and ts-node
* vim (builds from source to enable YouCompleteMe, which is a huge pain to install)
  - many plugins and scripts (see `./dotfiles/vimrc`)
  - plugin manager
* vscode
* many others
  - tmux git cmake apt-transport-https curl ca-certificates software-properties-common google-chrome-stable xclip snapd ffmpeg vlc [doctl](https://github.com/digitalocean/doctl)


### Fonts

* Fira Coda
* DejaVu
* Source Code Pro
* Hack
* Hasklig


### Overridable/extensible

If you need to extend a file, simply put it in the `custom` directory. If you need to override a file, simply add it to the `override` directory

* [aliases.sh](dotfiles/_aliases.sh): [bash aliases](https://www.tldp.org/LDP/abs/html/aliases.html) for convenience
* [fns.sh](dotfiles/_fns.sh): [bash functions](https://linuxize.com/post/bash-functions/)
* [bashrc.sh](dotfiles/_bashrc.sh): initialization script, does things like add scripts to path, set history size, enable bash autocompletion, changes to the `dev` directory, etc.
* [tmux.conf](dotfiles/_tmux.conf): [tmux configuration file](https://github.com/tmux/tmux)
* [vimrc](dotfiles/_vimrc): [vim run command](https://www.vim.org/)


### UI

You can run a UI customization script based on your desktop environment. This must be done manually.

* [xfce](ui/xfce.sh): run `sh ui/xfce.sh`
* [unity](ui/unity.sh): run `sh ui/unity.sh`

This adds themes and sets the background:



There are also a lot of aliases, funcions, and bash scripts in ./dotfiles/{_aliases.sh,_fns.sh,_bashrc.sh} and ./bin.

The bashrc will automatically add any file in ./bin to your path.

It also searches for overrides. So, if you want to override a file like bashrc, just create a file in the directory `override`, and your file will be instead.

If you want to extend one of the dotfiles, you can do that by adding to the `custom` directory. You can also add your own `setup.sh` file to the `custom` directory, and the script will be run after installation.

The `custom` directory is where I put stuff like secrets and things only I will need.

Note: if you do adjust the `custom` or `override` directory, you will want to remove it from `.gitignore`.

The `init.sh` file is what is run in the `wget`, and the `setup.sh` is run after the `init.sh`.

The dotfiles (aliases,fns.sh,vimrc,etc) are created with symbolic links to this directory (once you clone it), so you don't have to worry about copying files back and forth to update your configuration. Just `git pull` or `git push`.

### Make it your own

I encourage you to fork this repo and make it your own. If you stick to the `custom` and `override` diretories, you can always pull from this repo for any updates (I periodically update versions of things, add functions, etc.), or you can push to this repo, and I might accept a PR. Or you can completely customize it and let other people use your configuration. It is quite easy to do just by forking and having multiple branches and origins. If you completely mess up, you can always come back here.

If you do fork this repo and let others use your version, I would recommend having a private branch for your own personal use and to test stuff out and a public branch for the world to use. When you add something public, just merge it to your private branch.

### some of the bins

`bin/spoofmac` changes your mac address to get around coffee shop wifi limitations mostly.

`fingerguns` Changes your bash terminal to finger guns. Must be run with `source ~/zetup/bin/fingerguns`

`pfwd` forwards all passed ports from an ssh tunnel to your computer (useful for remote development)

  `tmux-split` use this all the time, just splits a tmux terminal into one smaller window on bottom and one larger window on top.

  `gitamend` amends to your last commit changing the message if provided, but leaving the message as is otherwise

  `gitpush` I use all the time, it just adds everything in your current repository, removes everthing that was deleted, commits with your provided message, and pushes the current branch to `origin`

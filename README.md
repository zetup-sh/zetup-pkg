# zetup

### To Run

`wget https://github.com/zwhitchcox/zetup/raw/master/init.sh && source init.sh`

OR

`curl https://github.com/zwhitchcox/zetup/raw/master/init.sh && source init.sh`

### within container

`apt update && apt install wget -y && wget https://github.com/zwhitchcox/zetup/raw/master/init.sh && source init.sh`


## What is this?

These are files I want to use every time I move to a new machine (ubuntu & (windows coming soon)).

If you run the above setup script, it prompts you for your username, email, and name and then installs many basic utilities (see ./init.sh) and then clones this repository and installs many development programs I use including the following:

* docker
* go
* kubernetes
* node
* vim (builds from source to enable YouCompleteMe, which is a huge pain to install)
* vlc

It also does things like make the UI prettier, change the background, install development fonts, add a bunch of vim plugins, vimrc, a tmux config, etc.

There are also a lot of aliases, funcions, and bash scripts in ./dotfiles/{_aliases.sh,_fns.sh,_bashrc.sh} and ./bin.

The bashrc will automatically add any file in ./bin to your path.

It also searches for overrides. So, if you want to override a file like bashrc, just create a directory

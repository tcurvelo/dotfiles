# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

setopt nocheckjobs
setopt nohup

alias l="ls --color=auto"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

plugins=(git git-extras)

source $ZSH/oh-my-zsh.sh
source ~/.profile

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin/

function dist-upgrade {
    sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get autoremove && sudo apt-get clean;
}


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

setopt nocheckjobs
setopt nohup

alias l="ls --color=auto"
alias gstb="git-status-bulk"
alias tmux="tmux -2"
alias vi="vim"
which nvim > /dev/null && \
  alias vim="nvim"
alias gv="gvim"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

plugins=(git git-extras)

HISTFILE=~/.history
source $ZSH/oh-my-zsh.sh
source ~/.profile

export CHROME_BIN=$(which chromium-browser 2> /dev/null)
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/.bin

export WORKON_HOME=~/.bin/envs
source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

export TERM=xterm-256color

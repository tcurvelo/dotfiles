source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle command-not-found
antigen bundle git
antigen bundle git-extras
antigen bundle hlissner/zsh-autopair
antigen bundle pip

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

setopt nocheckjobs
setopt nohup

alias l="ls --color=auto"
alias gstb="git-status-bulk"
alias tmux="tmux -2"
alias vi="vim"
which nvim > /dev/null && alias vim="nvim"

source ~/.profile
HISTFILE=~/.history

export BROWSER=/usr/bin/firefox
export CHROME_BIN=$(which chromium-browser 2> /dev/null)
export TERM=xterm-256color
export PATH=$PATH:$HOME/.local/bin:$HOME/.pyenv/bin:$HOME/.cargo/bin
export PROJECT_HOME=~/workspace
export PIPENV_VENV_IN_PROJECT=1
export HOMEBREW_NO_GITHUB_API=true

eval "$(direnv hook zsh)"

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

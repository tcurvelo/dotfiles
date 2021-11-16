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
alias icat="kitty +kitten icat"
alias c="code ."

export BROWSER=/usr/bin/firefox
export CHROME_BIN=$(which chromium-browser 2> /dev/null)
export HISTFILE=~/.history
export HOMEBREW_NO_GITHUB_API=true
export PATH=$HOME/.local/bin:$HOME/.pyenv/bin:$HOME/.cargo/bin:$PATH
export PIPENV_VENV_IN_PROJECT=1
export PROJECT_HOME=~/workspace
export TERM=xterm-256color
export TERMINAL=~/.local/bin/kitty

eval "$(direnv hook zsh)"

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

if ! which rg > /dev/null; then
  which ripgrep.rg > /dev/null && alias rg="ripgrep.rg";
fi

if which fzf > /dev/null; then
  # source ~/.fzf.zsh

  alias k='kubectl'
  # Get current context
  alias krc='k config current-context'
  # List all contexts
  alias klc='k config get-contexts -o name | sed "s/^/  /;\|^  $(krc)$|s/ /*/"'
  # Change current context
  alias kcc='k config use-context "$(klc | fzf -e | sed "s/^..//")"'
  # Get current namespace
  alias krn='k config get-contexts --no-headers "$(krc)" | awk "{print \$5}" | sed "s/^$/default/"'
  # List all namespaces
  alias kln='k get -o name ns | sed "s|^.*/|  |;\|^  $(krn)$|s/ /*/"'
  # Change current namespace
  alias kcn='k config set-context --current --namespace "$(kln | fzf -e | sed "s/^..//")"'
fi

source ~/.profile

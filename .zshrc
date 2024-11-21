# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  docker
  docker-compose
  git
  git-extras
  httpie
  kubectl
  pip
  ripgrep
)

ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*' menu select

setopt nocheckjobs
setopt nohup

alias l="ls --color=auto"
alias gstb="git-status-bulk"
alias tmux="tmux -2"
alias vi="vim"
alias icat="kitty +kitten icat"
alias c="code ."

export CHROME_BIN=$(which google-chrome 2> /dev/null)
export BROWSER=$CHROME_BIN
# export BROWSER=$(which firefox 2> /dev/null)
export HISTFILE=~/.history
export HOMEBREW_NO_GITHUB_API=true
export GOPATH=~/workspace/go
export PATH=$HOME/.local/bin:/usr/local/go/bin:$HOME/.cargo/bin:$GOPATH/bin:$PATH
export PIPENV_VENV_IN_PROJECT=1
export PROJECT_HOME=~/workspace
export TERM=xterm-256color
export TERMINAL=~/.local/bin/kitty

eval "$(direnv hook zsh)"

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

autoload -Uz compinit
fpath+=~/.zfunc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if which kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/curvelo/.local/bin/nomad nomad

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

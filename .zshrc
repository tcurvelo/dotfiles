export ZSH="$HOME/.oh-my-zsh"

plugins=(
  docker
  docker-compose
  git
  git-extras
  httpie
  kubectl
  pip
)

ZSH_THEME="bureau"
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

export CHROME_BIN=$(which google-chrome 2> /dev/null)
export BROWSER=$CHROME_BIN
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

for _f in $HOME/.profile.d/**/*(.N); do source "$_f"; done; unset _f

autoload -Uz compinit
fpath+=~/.zfunc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit

for _zsh_plugin in \
  "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [[ -r "$_zsh_plugin" ]] && source "$_zsh_plugin" && break
done

for _zsh_plugin in \
  "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -r "$_zsh_plugin" ]] && source "$_zsh_plugin" && break
done
unset _zsh_plugin

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="jb55"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

export DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

export NIXPKGS=$HOME/nixpkgs
export NIX_PATH="nixpkgs=$NIXPKGS:monstercatpkgs=$HOME/etc/monstercatpkgs:$NIX_PATH"

# Customize to your needs...

[ -e $HOME/.profile ] && source $HOME/.profile

# other
export EDITOR=vim
export PAGER=less

# go

export GOPATH=$HOME/dev/gocode
export PATH=$HOME/.npm/bin:$GOPATH/bin:$PATH

# alias

alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias ack="ack --pager='less -R'"
alias csv="column -s, -t <"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias wget="wget -c"
alias tmux="tmux -2"
alias page=$PAGER
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
alias crontab="VIM_CRONTAB=true crontab"
alias st="git sourcetree"
alias clip="xclip -selection clipboard"
alias ls="ls --color"
alias jsonpp="python -mjson.tool"
alias prettyjson=jsonpp
alias catt="pygmentize -O style=monokai -f console256 -g"
alias tmuxa="tmux a -d -t "
alias sorry='sudo $(fc -l -n -1)'
alias ag="ag --pager less"

alias open=xdg-open
alias emacs="env TERM=xterm-256color emacs"
alias attach="grabssh; screen -rD"
alias fixssh="source $HOME/bin/fixssh"

# fix ssh agent forwarding in screen
FIXSSH=$HOME/bin/fixssh
if [[ $TERM == screen* ]] && [[ -f $FIXSSH ]]; then
  source $FIXSSH
fi

export PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/jb55/.travis/travis.sh ] && source /Users/jb55/.travis/travis.sh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# z
source "$HOME/bin/z.sh"

export BARI=$HOME/Dropbox/shared/bari

alias noder="env NODE_NO_READLINE=1 rlwrap node"
alias nr="npm run"
alias xclip="xclip -selection clipboard"

env-type () {
  envtype="$1"
  shift
  nix-shell -Q -j6 -p $envtype "$@"
}

haskell-env () {
  env-type "haskellEnv" "$@"
}

haskell-env-hoogle () {
  env-type "haskellEnvHoogle" "$@"
}

haskell-env-tools() {
  env-type "haskellTools" "$@"
}

cdl () {
  cd "$(dirname "$(readlink -f "$(whence "$1")")")"
}

vnc_once () {
  x11vnc -safer -nopw -once -display :0 $1
}

DIRCOLORS="$HOME/.dircolors"
[ -e "$DIRCOLORS" ] && eval "$(dircolors -b "$DIRCOLORS")"

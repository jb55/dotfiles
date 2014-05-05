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

export PLATFORM="mac"

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

export SCANBUILD=$HOME/dev/checker
export CABALBIN=$HOME/.cabal/bin
export CLOJURESCRIPT_HOME=$HOME/dev/clojurescript
export COSH_BIN=$SCHEME_DIR/cosh/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools
export ECLIPSE_WORKSPACE=$HOME/src/java
export EDITOR=vim
export HASKELL_HOME=$HOME/Library/Haskell
export MIRAH_BIN=$HOME/dev/mirah-0.0.8.dev/bin
export PLAY_HOME=$HOME/dev/play-2.0.2
export ROY_BIN=$HOME/dev/roy
export SCALA_HOME=$HOME/dev/scala-2.9.2
export SCHEME_DIR=$HOME/dev/scheme
export TEXBIN=/usr/texbin
export NPM=/usr/local/share/npm
export VICARE_BIN=$SCHEME_DIR/vicare/bin
export VICARE_LIBRARY_PATH=$SCHEME_DIR/scheme-tools:$SCHEME_DIR/bher:$SCHEME_DIR/scheme-transforms:$SCHEME_DIR/cosh:$SCHEME_DIR/board
export NW_BIN=$HOME/dev/node-webkit-v0.9.2-linux-x64

export NODE_PATH=/usr/local/lib/node_modules

export LUA_HOME=/opt/local/share/luarocks
export LUA_BIN=$LUA_HOME/bin

# GO
export GOPATH=$HOME/dev/gocode

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$PATH:$GOPATH/bin

export PATH=$CABALBIN:$PATH
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH
export PATH=$COSH_BIN:$PATH
export PATH=$DEPOT_TOOLS:$PATH
export PATH=$HASKELL_HOME/bin:$PATH
export PATH=$LUA_BIN:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MIRAH_BIN:$PATH
export PATH=$PLAY_HOME:$PATH
export PATH=$ROY_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$TEXBIN:$PATH
export PATH=$SCANBUILD:$PATH
export PATH=$NPM/bin:$PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$NW_BIN:$PATH

[ -e $HOME/.profile ] && source $HOME/.profile

# GO
export GOROOT=$HOME/dev/go
export GOBIN=$HOME/bin
export GOOS=darwin
export GOARCH=amd64

# other
export EDITOR=vim
export PAGER=less

# alias
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias ack="ack --pager='less -R'"
alias csv="column -s, -t <"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
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
source $HOME/bin/z.sh

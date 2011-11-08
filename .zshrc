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

export EDITOR=vim
export TEXBIN=/usr/texbin
export SCALA_HOME=$HOME/dev/scala-2.9.1.final
export HASKELL_HOME=$HOME/Library/Haskell
export CABALBIN=$HOME/.cabal/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools
export M2_REPO=$HOME/.m2/repository
export M2_HOME=$HOME/dev/apache-maven-3.0.3
export ECLIPSE_WORKSPACE=$HOME/src/java
export MIRAH_BIN=$HOME/dev/mirah-0.0.8.dev/bin
export SCHEME_DIR=$HOME/dev/scheme
export COSH_BIN=$SCHEME_DIR/cosh/bin
export VICARE_LIBRARY_PATH=$SCHEME_DIR/scheme-tools:$SCHEME_DIR/bher:$SCHEME_DIR/scheme-transforms:$SCHEME_DIR/cosh:$SCHEME_DIR/board

export LUA_HOME=/opt/local/share/luarocks
export LUA_BIN=$LUA_HOME/bin

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/opt/local/bin:$CABALBIN:$TEXBIN:$DEPOT_TOOLS:$M2_HOME/bin:$MIRAH_BIN:$SCALA_HOME/bin:$HASKELL_HOME/bin:$COSH_BIN:$LUA_BIN

# GO
export GOROOT=$HOME/dev/go
export GOBIN=$HOME/bin
export GOOS=linux
export GOARCH=amd64

# other
export EDITOR=vim
export PAGER=less

# alias
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias ack="ack --pager='less -R'"
alias glg="git log --graph"
alias csv="column -s, -t <"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
alias wget="wget -c"
alias tmux="tmux -2"
alias page=$PAGER
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
alias crontab="VIM_CRONTAB=true crontab"

eval `gdircolors ~/.dircolors`


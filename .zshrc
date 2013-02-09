# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="jb55"

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

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
export PLAY_HOME=$HOME/dev/play-2.0.2
export SCALA_HOME=$HOME/dev/scala-2.9.2
export HASKELL_HOME=$HOME/Library/Haskell
export CABALBIN=$HOME/.cabal/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools
export ECLIPSE_WORKSPACE=$HOME/src/java
export MIRAH_BIN=$HOME/dev/mirah-0.0.8.dev/bin
export SCHEME_DIR=$HOME/dev/scheme
export COSH_BIN=$SCHEME_DIR/cosh/bin
export VICARE_LIBRARY_PATH=$SCHEME_DIR/scheme-tools:$SCHEME_DIR/bher:$SCHEME_DIR/scheme-transforms:$SCHEME_DIR/cosh:$SCHEME_DIR/board
export ROY_BIN=$HOME/dev/roy
export JAVA_HOME=$HOME/dev/jdk1.7.0_05
export JAVA_BIN=$HOME/dev/jdk1.7.0_05/bin
export CLOJURESCRIPT_HOME=$HOME/dev/clojurescript

export NODE_PATH=/usr/local/lib/node_modules

export LUA_HOME=/opt/local/share/luarocks
export LUA_BIN=$LUA_HOME/bin

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$PATH

export PATH=$CABALBIN:$PATH
export PATH=$TEXBIN:$PATH
export PATH=$DEPOT_TOOLS:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MIRAH_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$HASKELL_HOME/bin:$PATH
export PATH=$COSH_BIN:$PATH
export PATH=$LUA_BIN:$PATH
export PATH=$ROY_BIN:$PATH
export PATH=$PLAY_HOME:$PATH
export PATH=$JAVA_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH

source $HOME/.profile

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
alias st="git sourcetree"
alias clip="xclip -selection clipboard"
alias open=gnome-open

eval `dircolors ~/.dircolors`

alias android-connect=mtpfs /media/s2 -o allow_other
alias android-disconnect=fusermount -u /media/s2

# sysreq for apple keyboards

APPLE_KEYBOARD="/dev/input/by-id/usb-Apple_Inc._Apple_Keyboard-event-kbd"
if [ -f $APPLE_KEYBOARD ];
then
  echo "458856 99" | keyfuzz -s -d $APPLE_KEYBOARD
fi

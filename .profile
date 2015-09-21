#!/bin/bash

# nix
. /Users/jb55/.nix-profile/etc/profile.d/nix.sh
export NIXPKGS=$HOME/dev/nixpkgs
export NIX_PATH="$NIXPKGS:nixpkgs=$NIXPKGS:monstercatpkgs=$HOME/dev/monstercatpkgs"

# sharefile
export SHAREFILE_HOST=jb55.com:public/s/
export SHAREFILE_URL=http://jb55.com/s/

export CABALBIN=$HOME/.cabal/bin
export CLOJURESCRIPT_HOME=$HOME/dev/clojurescript
export COSH_BIN=$SCHEME_DIR/cosh/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools
export ECLIPSE_WORKSPACE=$HOME/src/java
export EDITOR=vim
export VISUAL=vim
export GOROOT=$HOME/dev/go
export GOHOME=$GOROOT
export HASKELL_HOME=$HOME/Library/Haskell
export LUA_BIN=$LUA_HOME/bin
export LUA_HOME=/opt/local/share/luarocks
export MIRAH_BIN=$HOME/dev/mirah-0.0.8.dev/bin
export NIMBLEPATH=$HOME/.nimble
export NIMPATH=$HOME/bin/nim
export NODE_PATH=/usr/local/lib/node_modules
export NPM=/usr/local/share/npm
export NW_BIN=$HOME/dev/node-webkit-v0.9.2-linux-x64
export PLAY_HOME=$HOME/dev/play-2.0.2
export ROY_BIN=$HOME/dev/roy
export SCALA_HOME=$HOME/dev/scala-2.9.2
export SCANBUILD=$HOME/dev/checker
export SCHEME_DIR=$HOME/dev/scheme
export TEXBIN=/usr/texbin
export VICARE_BIN=$SCHEME_DIR/vicare/bin
export VICARE_LIBRARY_PATH=$SCHEME_DIR/scheme-tools:$SCHEME_DIR/bher:$SCHEME_DIR/scheme-transforms:$SCHEME_DIR/cosh:$SCHEME_DIR/board

export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH

export PAGER=less
export EDITOR=vim

export GOPATH=$HOME/dev/gocode

export PATH=$HASKELL_HOME/bin:$PATH
export PATH=$CABALBIN:$PATH
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH
export PATH=$COSH_BIN:$PATH
export PATH=$DEPOT_TOOLS:$PATH
export PATH=$GOHOME/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$LUA_BIN:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$MIRAH_BIN:$PATH
export PATH=$NIMBLEPATH/bin:$PATH
export PATH=$NIMPATH/bin:$PATH
export PATH=$NPM/bin:$PATH
export PATH=$NW_BIN:$PATH
export PATH=$PLAY_HOME:$PATH
export PATH=$ROY_BIN:$PATH
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$SCANBUILD:$PATH
export PATH=$TEXBIN:$PATH

export MANPATH=/usr/share/man:$MANPATH
export MANPATH=$HOME/.nix-profile/share/man:$MANPATH
export BARI=$HOME/Dropbox/shared/bari

alias ack="ack --pager='less -R'"
alias attach="grabssh; screen -rD"
alias catt="pygmentize -O style=monokai -f console256 -g"
alias clip="xclip -selection clipboard"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias crontab="VIM_CRONTAB=true crontab"
alias emacs="env TERM=xterm-256color emacs"
alias fixssh="source $HOME/bin/fixssh"
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias jsonpp="python -mjson.tool"
alias ls="ls --color"
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
alias noder="env NODE_NO_READLINE=1 rlwrap node"
alias nr="npm run"
alias page=$PAGER
alias prettyjson=jsonpp
alias sorry='sudo $(fc -l -n -1)'
alias st="git sourcetree"
alias tmux="tmux -2"
alias tmuxa="tmux a -d -t "
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
alias wget="wget -c"
alias nfmt="numfmt --to=si"

share() { sharefile "$@" | pbcopy }
sharess() { share_last_ss | pbcopy }
lt() { ls -lt | less }
prettycsv() { csv-columnify "$@" | less -S }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/jb55/.travis/travis.sh ] && source /Users/jb55/.travis/travis.sh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# z
source $HOME/bin/z.sh

# nix
. /Users/jb55/.nix-profile/etc/profile.d/nix.sh

CURL_CA_BUNDLE=/opt/local/share/curl/curl-ca-bundle.crt

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


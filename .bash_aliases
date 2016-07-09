#!/usr/bin/env bash

# generic stuff for non-interactive shells

# sharefile
export SHAREFILE_HOST='jb55.com:public/s/'
export SHAREFILE_URL='https://jb55.com/s/'
export SHARE_SS_DIR="$HOME/Dropbox/img/ss"
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
export XZ=pxz

alias ag="ag --pager="less -R""
alias attach="grabssh; screen -rD"
alias awkt="awk -F $'\t'"
alias catt="pygmentize -O style=monokai -f console256 -g"
alias clip="xclip -selection clipboard"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias crontab="VIM_CRONTAB=true crontab"
alias cutt="cut -d $'\t' --output-delimiter=$'\t'"
alias emacs="env TERM=xterm-256color emacs"
alias fixssh="source $HOME/bin/fixssh"
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias gpg=gpg2
alias jsonpp="python -mjson.tool"
alias ls="ls --color"
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
alias nfmt="numfmt --to=si"
alias noder="env NODE_NO_READLINE=1 rlwrap node"
alias nr="npm run"
alias open=xdg-open
alias page=$PAGER
alias prettyjson=jsonpp
alias sorry='sudo $(fc -l -n -1)'
alias st="git sourcetree"
alias tmuxa="tmux a -d -t "
alias tmux="tmux -2"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
alias wget="wget -c"
alias xclip="xclip -selection clipboard"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias wanip=myip
alias myipaddress=myip


share () {
  sharefile "$@" | xclip
}

sharess () {
  share_last_ss | xclip
}

lt () {
  ls -lt "$@" | "$PAGER"
}

lt1 () {
  ls -t "$@" | head -n1
}

mv1 () {
  mv $(lt1 | stripansi) "$@"
}

columnt () {
  column -t -s $'\t' "$@"
}

pcsv () {
  csv-delim "$@" | pcsvt
}

pcsvt () {
  columnt "$@" | cat -n | less -R -S
}

monstercam() {
  ssh archer "ffmpeg -f alsa -ar 16000 -i default -f v4l2 -s 640x480 -i /dev/video0 -f avi -pix_fmt yuv420p -"
}

monstercam-live() {
  monstercam | tee /sand/vid/monstercam.avi \
             | ffplay -
}

headers() {
  head -n1 ${1:-"/dev/stdin"} | csv-delim | tr '\t' '\n' | cat -n
}

nsum() {
  awkt '{total = total + $1}END{print total}'
}

sumcol() {
  cut -f $1 | nsum
}

uniqc() {
  sort "$@" | uniq -c | sort -nr
}

cdl () {
  cd "$(dirname "$(readlink -f "$(which "$1")")")"
}

env-type () {
  envtype="$1"
  shift
  nix-shell -Q -p $envtype "$@"
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

build-nix-cache() {
  nix-env -f $NIXPKGS -qaP \* > ~/.nixenv.cache
}

haskell-shell() {
  nix-shell -Q -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [$*])"
}

vnc-once() {
  x11vnc -safer -nopw -once -display ':0' $1
}

sql_wineparty() {
  export CS='postgres://wineparty.xyz/wineparty'
  export PG_USER='jb55'
}

sql_() {
  local query="$1"
  local cs=${CS:-'postgres://pg-dev-zero.monstercat.com/Monstercat'}
  local pg_user=${PG_USER:-'jb55'}
  local args=("-U" "$pg_user" -A "$cs")
  if [ ! -z "$query" ];
  then
    args+=(-c "$query")
  fi
  psql -F $'\t' "${args[@]}"
}

sql() {
  sql_ "$@" | pcsvt
}


source $DOTFILES/bash/rangercd.sh

# fzf
source $DOTFILES/.fzf_helpers

# z
source $HOME/bin/z.sh

# nix
#. /Users/jb55/.nix-profile/etc/profile.d/nix.sh

CURL_CA_BUNDLE=/opt/local/share/curl/curl-ca-bundle.crt

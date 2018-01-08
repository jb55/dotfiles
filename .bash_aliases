#!/usr/bin/env bash

# generic stuff for non-interactive shells

# sharefile
export SHAREFILE_HOST='charon:public/s/'
export SHAREFILE_URL='https://jb55.com/s/'
export SHARE_SS_DIR="$HOME/var/img/ss"
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
export XZ=pxz
export HISTSIZE=50000
export FZF_CTRL_R_OPTS="-e"
export FZF_DEFAULT_OPTS="-e"

alias info="info --vi-keys"
alias ag="ag --pager=less"
alias attach="grabssh; screen -rD"
alias awkt="awk -v FS=$'\t' -v OFS=$'\t'"
alias catt="pygmentize -O style=monokai -f console256 -g"
alias clip="xclip -selection clipboard"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias crontab="VIM_CRONTAB=true crontab"
alias cutt="cut -d $'\t' --output-delimiter=$'\t'"
alias emacs="env TERM=xterm-256color emacs"
alias fixssh="source $HOME/bin/fixssh"
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias jsonpp="python -mjson.tool"
alias ls="ls --color"
alias mvne="mvn -Declipse.workspace=$ECLIPSE_WORKSPACE eclipse:add-maven-repo"
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
alias ns="nix-shell -p"
alias fzf="fzf --exact"


ghclone () {
  cd "$(gh-clone "$@")"
}

cdnp () {
  nix-build '<nixpkgs>' --no-out-link -A "$1"
  cd $(nix-path "$1")
}

np () {
  nix-path "$1"
}

nsr () {
  local cmd="$1"
  shift
  nix-shell -p "$cmd" --run "$@"
}

nsr2 () {
    local cmd="$1"
    shift
    local cmd2="$(<<<"$cmd" rev | cut -d. -f1 | rev) $@"
    nsr "$cmd" "$cmd2"
}

nsc () {
  local cmd="$1"
  shift
  nix-shell -p "$cmd" --command "$@"
}

share () {
  sharefile "$@" | xclip
}

sharess () {
  share_last_ss | xclip
}

lt () {
  ls -ltah "$@" | "$PAGER"
}

lt1 () {
  ls -t "$@" | head -n1
}

mv1 () {
  mv $(lt1 | stripansi) "$@"
}

pcsv () {
  csv-delim "$@" | pcsvt
}

pcsvt () {
  columnt "$@" | cat -n | less -R -S
}

monstercam() {
  ssh archer "ffmpeg -f alsa -ar 16000 -ac 1 -i hw:2 -f v4l2 -s 640x480 -i /dev/video0 -f avi -pix_fmt yuv420p -"
}

monstercam-live() {
  monstercam | tee /sand/vid/monstercam.avi \
             | ffplay -
}

header() {
  headers "${2:-/dev/stdin}" | grep "$1" | cutt -f1 | sed -E 's,^[ ]*,,g'
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
  nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [$*])"
}

nix-path() {
  nix-instantiate --eval --expr 'with import <nixpkgs> {}; "${'"$1"'}"' | sed 's/"//g'
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
  local args=("-U" "$pg_user" -A)
  if [ ! -z "$query" ];
  then
    args+=(-c "$query")
  fi
  psql -F $'\t' "${args[@]}"
}

sql() {
  sql_ "$@" | pcsvt
}

# fzf
source $DOTFILES/.fzf_helpers

# z
source $HOME/bin/z.sh

# nix
#. /Users/jb55/.nix-profile/etc/profile.d/nix.sh

CURL_CA_BUNDLE=/opt/local/share/curl/curl-ca-bundle.crt

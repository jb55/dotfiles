#!/bin/bash

# sharefile
export SHAREFILE_HOST=jb55.com:public/s/
export SHAREFILE_URL=http://jb55.com/s/
export XZ=pxz

alias ag="ag --pager=less"
alias gpg=gpg2
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
alias cutt="cut -d $'\t' --output-delimiter=$'\t'"
alias awkt="awk -F $'\t'"

share() { sharefile "$@" | pbcopy }
sharess() { share_last_ss | pbcopy }
lt() { ls -lt "$@" | less }

prettycsv() {
  csv-delim "$@" | column -t -s $'\t' | less -S
}

headers() { head -n1 ${1:-"/dev/stdin"} | csv-delim | tr '\t' '\n' | cat -n }
nsum() { awkt '{total = total + $1}END{print total}' }
sumcol() { cut -f $1 | nsum }
uniqc() { sort "$@" | uniq -c | sort -nr }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# z
source $HOME/bin/z.sh

# nix
#. /Users/jb55/.nix-profile/etc/profile.d/nix.sh

CURL_CA_BUNDLE=/opt/local/share/curl/curl-ca-bundle.crt


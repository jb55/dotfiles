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

source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

export TEXBIN=/usr/texbin
export CABALBIN=$HOME/.cabal/bin
export DEPOT_TOOLS=$HOME/dev/depot_tools

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/opt/local/bin:$CABALBIN:$TEXBIN:$DEPOT_TOOLS

# GO
export GOROOT=$HOME/dev/go
export GOBIN=$HOME/bin
export GOOS=linux
export GOARCH=386

# alias
alias githist="git reflog show | grep '}: commit' | nl | sort -nr | nl | sort -nr | cut --fields=1,3 | sed s/commit://g | sed -e 's/HEAD*@{[0-9]*}://g'"
alias ack="ack --pager='less -R'"
alias glg="git log --graph"
alias csv="column -s, -t <"
alias vless="/usr/share/vim/vim72/macros/less.sh"
alias cpptags="ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"
alias vnc_once="x11vnc -safer -nopw -once -display :0"
alias wget="wget -c"

eval `dircolors ~/.dircolors`


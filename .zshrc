# Path to your oh-my-zsh configuration.
#export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="jb55"

#export DISABLE_AUTO_UPDATE="true"
#source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

# short ESC delay
export KEYTIMEOUT=1

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

export NIXPKGS=$HOME/nixpkgs
export NIX_FILES=$HOME/etc/nix-files

# nix paths
export NIX_PATH="nixpkgs=$NIXPKGS:$NIX_PATH"
export NIX_PATH="nixos-config=$NIX_FILES:$NIX_PATH"
export NIX_PATH="monstercatpkgs=$HOME/etc/monstercatpkgs:$NIX_PATH"
export NIX_PATH="jb55pkgs=$HOME/etc/jb55pkgs:$NIX_PATH"
export NIX_PATH="dotfiles=$HOME/.dotfiles:$NIX_PATH"

# Customize to your needs...

[ -e $HOME/.profile ] && source $HOME/.profile

# other
export EDITOR=vim
export PAGER=less
export LESS="-R"

# go

export GOPATH=$HOME/dev/gocode
export RUBYBIN=$HOME/.ruby/1.8/gems/bin
export PATH=$RUBYBIN:$HOME/.npm/bin:$GOPATH/bin:$PATH

# alias

# fix ssh agent forwarding in screen
FIXSSH=$HOME/bin/fixssh
if [[ $TERM == screen* ]] && [[ -f $FIXSSH ]]; then
  source $FIXSSH
fi


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export GEM_HOME="$HOME/.ruby/1.8/gems"
export GEM_PATH="$GEM_HOME"

# added by travis gem
[ -f /Users/jb55/.travis/travis.sh ] && source /Users/jb55/.travis/travis.sh

# z
source "$HOME/bin/z.sh"

export BARI=$HOME/Dropbox/shared/bari


ALIASES="$HOME/.bash_aliases"
[ -e "$ALIASES" ] && source "$ALIASES"

DIRCOLORS="$HOME/.dircolors"
[ -e "$DIRCOLORS" ] && eval "$(dircolors -b "$DIRCOLORS")"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# Path to your oh-my-zsh configuration.
#export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="jb55"

#export DISABLE_AUTO_UPDATE="true"
#source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

setopt HIST_IGNORE_SPACE
setopt AUTO_PUSHD
setopt PUSHD_MINUS
setopt CDABLE_VARS
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

# short ESC delay
export KEYTIMEOUT=1

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

# history settings
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

export NIXPKGS=$HOME/nixpkgs
export NIX_FILES=$HOME/etc/nix-files

# nix paths
export NIX_PATH="nixpkgs=$NIXPKGS:$NIX_PATH"
export NIX_PATH="nixos-config=$NIX_FILES:$NIX_PATH"
export NIX_PATH="monstercatpkgs=$HOME/etc/monstercatpkgs:$NIX_PATH"
export NIX_PATH="jb55pkgs=$HOME/etc/jb55pkgs:$NIX_PATH"
export NIX_PATH="dotfiles=$HOME/dotfiles:$NIX_PATH"

# Customize to your needs...

[ -e $HOME/.profile ] && source $HOME/.profile

# other
export EDITOR="emacsclient -s $HOME/.emacs.d/server/server -c -a vim"
export VISUAL="emacsclient -s $HOME/.emacs.d/server/server -c -a emacs"
export BROWSER="qbrowser"
export PAGER=less
export LESS="-R"

# go

export GOPATH=$HOME/dev/gocode
export RUBYBIN=$HOME/.ruby/1.8/gems/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$RUBYBIN:$HOME/.npm/bin:$GOPATH/bin:$PATH
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

export FZF_DEFAULT_OPTS="--color=light"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

# undistract-me is great
[ -e $HOME/dotfiles/zsh/undistract-me.zsh ] && . $HOME/dotfiles/zsh/undistract-me.zsh

# added by travis gem
[ -f /home/jb55/.travis/travis.sh ] && source /home/jb55/.travis/travis.sh

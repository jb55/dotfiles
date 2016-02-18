# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="jb55"

export DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

# vi
bindkey -v

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

# go

export GOPATH=$HOME/dev/gocode
export PATH=$HOME/.npm/bin:$GOPATH/bin:$PATH

# alias

# fix ssh agent forwarding in screen
FIXSSH=$HOME/bin/fixssh
if [[ $TERM == screen* ]] && [[ -f $FIXSSH ]]; then
  source $FIXSSH
fi

export PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'
ulimit -n 1024

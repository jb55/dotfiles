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

export PLATFORM="mac"

bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

# shared paths 
[ -e $HOME/.profile ] && source $HOME/.profile

# fix ssh agent forwarding in screen
FIXSSH=$HOME/bin/fixssh
if [[ $TERM == screen* ]] && [[ -f $FIXSSH ]]; then
  source $FIXSSH
fi

export PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'
ulimit -n 1024

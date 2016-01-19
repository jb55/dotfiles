# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jb55/.fzf/bin* ]]; then
  export PATH="$PATH:/home/jb55/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/jb55/.fzf/man* && -d "/home/jb55/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/jb55/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jb55/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/jb55/.fzf/shell/key-bindings.zsh"


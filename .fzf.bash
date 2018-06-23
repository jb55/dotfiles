# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jb55/.fzf/bin* ]]; then
  export PATH="$PATH:/home/jb55/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jb55/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/jb55/.fzf/shell/key-bindings.bash"


# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/timwolf/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/timwolf/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/timwolf/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/timwolf/.fzf/shell/key-bindings.zsh"


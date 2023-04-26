# Setup fzf
# ---------
if [[ ! "$PATH" == */home/henrik/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/henrik/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/henrik/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/henrik/.fzf/shell/key-bindings.bash"

# Print tree structure in the preview window

export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

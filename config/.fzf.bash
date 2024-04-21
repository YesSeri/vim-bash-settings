# Setup fzf
# ---------
if [[ ! "$PATH" == */home/esther-zenkert/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/esther-zenkert/.fzf/bin"
fi

eval "$(fzf --bash)"

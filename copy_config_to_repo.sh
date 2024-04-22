#!/usr/bin/env bash

cp ~/.bashrc ~/.bash_aliases ~/.fzf.bash ./config
cp -r ~/.config/bat/ ~/.config/i3/ ~/.config/kitty/ ~/.config/nvim/ ~/.config/tig/ ./config/.config
cp -r ~/.emacs.d/init.el  ./config/.emacs.d/init.el

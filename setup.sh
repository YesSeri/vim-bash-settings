#!/bin/bash                                                                                                                                                                                  
# A Bash script, by Henrik Zenkert 

# This makes a symlink that we then source from the .bashrc
ln -f .bashrc_aliases ~/.bashrc_aliases

# This adds the LINE to FILE if LINE doesn't exist in FILE. The dot command == Source
LINE='[ -f $HOME/.bashrc_aliases ] && . $HOME/.bashrc_aliases'
grep -qF "$LINE" ~/.bashrc || echo $LINE >> ~/.bashrc

# Source the file so it works in the current shell
. $HOME/.bashrc_aliases

# Clones Vundle if it doesn't exist into the vim folder. Vundle is plugin handler.
git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null

# Makes symlink to the .vimrc from the folder of the script and installs plugins
ln -f .vimrc ~/.vimrc && vim +PluginInstall +qall

echo "Install complete"

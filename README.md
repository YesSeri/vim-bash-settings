# .vimrc file
This is my .vimrc file. It is here for easy access between different computers. I need to install vundle manually when at a new computer. 

Create a symlink. The .vimrc file needs to be in ~/.vimrc for vim to register it. -s means soft symlink and -f means it overwrites in case there is already a file there. 

To get it running use this command. 

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -f .vimrc ~/.vimrc && vim +PluginInstall +qall
```

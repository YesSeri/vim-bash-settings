# .vimrc file
This is my .vimrc file. It is here for easy access between different computers. I need to install vundle manually when at a new computer. 

Create a symlink. The .vimrc file needs to be in ~/.vimrc for vim to register it. -s means soft symlink and -f means it overwrites in case there is already a file there. 

To get it running use this command. 

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -f .vimrc ~/.vimrc && vim +PluginInstall +qall
```
# .bashrc_aliases file

This is an extra file, which I will put in ~ folder and Source from /.bashrc

Add this to ~/.bashrc

```bash
grep -qF '[ -f $HOME/.bashrc_aliases ] && . $HOME/.bashrc_aliases' ~/.bashrc || echo '[ -f $HOME/.bashrc_aliases ] && . $HOME/.bashrc_aliases' >> ~/.bashrc
ln -f .bashrc_aliases ~/.bashrc_aliases
```


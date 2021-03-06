# Vim and bash setting - Henrik Zenkert

## .vimrc file
`.vimrc` is here for easy access between different computers. I need to install vundle manually when at a new computer. 

I create a hard symlink between the repo and the place where it is read. The .vimrc file needs to be in `~/.vimrc` for vim to register it. -s means soft symlink and -f means it overwrites in case there is already a file there. 

## .bashrc_aliases file

This is an extra file, which I will put in ~ folder and Source from `~/.bashrc`

## Install

One way of installing is to install the repo and just run `setup.sh`
```
git clone git@github.com:YesSeri/vim-bash-settings.git ~/.vim/vim-bash-settings
cd ~/.vim/vim-bash-settings
./setup.sh
```

To get it running execute `setup.sh` or use this command. For detailed info, read the comments in the `setup.sh` file.

```bash
ln -f .bashrc_aliases ~/.bashrc_aliases                                                                                                                                                                                                                      
grep -qF "[ -f $HOME/.bashrc_aliases ] && . $HOME/.bashrc_aliases" ~/.bashrc || echo "[ -f $HOME/.bashrc_aliases ] && . $HOME/.bashrc_aliases" >> ~/.bashrc                                                                                                  
. $HOME/.bashrc_aliases                                                                                                                                                                                                                                      
git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null                                                                                                                                                          
ln -f .vimrc ~/.vimrc && vim +PluginInstall +qall
```

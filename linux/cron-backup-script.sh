#!/usr/bin/env bash

cp /home/henrik/.config/bat/config 		/home/henrik/programming/docs/vim-bash-settings/linux/config/bat/config
cp /home/henrik/.bashrc					/home/henrik/programming/docs/vim-bash-settings/linux/config/bashrc
cp /home/henrik/.fzf.bash 			   	/home/henrik/programming/docs/vim-bash-settings/linux/config/fzf.bash
cp /home/henrik/.bash_aliases  		   	/home/henrik/programming/docs/vim-bash-settings/linux/config/bash_aliases
cp /home/henrik/.config/nvim/init.vim  	/home/henrik/programming/docs/vim-bash-settings/linux/config/nvim/init.vim
cp -r /home/henrik/.doom.d 				/home/henrik/programming/docs/vim-bash-settings/linux/config/doom.d

git add /home/henrik/programming/docs/vim-bash-settings/linux/config/bat/config /home/henrik/programming/docs/vim-bash-settings/linux/config/bashrc /home/henrik/programming/docs/vim-bash-settings/linux/config/fzf.bash /home/henrik/programming/docs/vim-bash-settings/linux/config/bash_aliases /home/henrik/programming/docs/vim-bash-settings/linux/config/nvim/init.vim /home/henrik/programming/docs/vim-bash-settings/linux/config/doom.d

git commit -m "Backup: $(date)"

git push origin main

echo "$(date) : backup to git"

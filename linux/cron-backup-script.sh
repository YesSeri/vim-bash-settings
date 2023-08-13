#!/usr/bin/env bash

cp /home/henrik/.config/bat/config 		/home/henrik/programming/docs/vim-bash-settings/linux/config/bat/config
cp /home/henrik/.bashrc					/home/henrik/programming/docs/vim-bash-settings/linux/config/bashrc
cp /home/henrik/.fzf.bash 			   	/home/henrik/programming/docs/vim-bash-settings/linux/config/fzf.bash
cp /home/henrik/.bash_aliases  		   	/home/henrik/programming/docs/vim-bash-settings/linux/config/bash_aliases
cp -r /home/henrik/.config/nvim		 	/home/henrik/programming/docs/vim-bash-settings/linux/config/nvim
cp -r /home/henrik/.doom.d 				/home/henrik/programming/docs/vim-bash-settings/linux/config/doom.d


if [[ `git status --porcelain` ]]; then

	git add /home/henrik/programming/docs/vim-bash-settings
	git commit -m "Backup: $(date)"

	git push origin main

	echo "$(date) : backup to git" >> /home/henrik/programming/docs/vim-bash-settings/linux/script.log

else
	echo "$(date) : nothing to backup" >> /home/henrik/programming/docs/vim-bash-settings/linux/script.log
fi


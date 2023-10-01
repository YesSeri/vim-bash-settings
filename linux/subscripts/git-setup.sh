EMAIL="henrik.zenkert@gmail.com"
NAME="Henrik Zenkert"
# update everything
sudo apt update && sudo apt upgrade -y
# install git, if I want to download this repo
sudo apt install git
# setup git
git config --global user.email $EMAIL
git config --global user.name $NAME
# create ssh key
ssh-keygen -t ed25519 -C $EMAIL -N '' -f $HOME/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519


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

# install essentials
sudo apt install curl build-essential pandoc qbittorrent htop sox zathura nnn brightnessctl xclip nautilus-dropbox audacity musescore vlc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install neovim
sudo snap install nvim --classic

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
PATH=$PATH:$HOME/.cargo/bin
# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install binstall and rust programs
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall --no-confirm ripgrep fd-find zoxide --locked bat xh

# Install from source to get latest version. apt version is missing many features, e.g. ctrl-t, ctrl-r, alt-c, etc.
sudo snap install tree bitwarden

# Mullvad
wget -P ~/Downloads/ --content-disposition https://mullvad.net/download/app/deb/latest && sudo apt install -y ~/Downloads/MullvadVPN*md64.deb


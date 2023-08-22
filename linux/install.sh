sudo apt update && sudo apt upgrade -y
sudo apt install git
sudo apt install curl build-essential pandoc qbittorrent wireshark htop sox zathura nnn brightnessctl xclip nautilus-dropbox audacity musescore vlc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo snap install nvim --classic
. '~/.bashrc'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall bat

# Replacement for find. 
cargo binstall --no-confirm ripgrep fd-find zoxide --locked bat xh

# Install from source to get latest version. apt version is missing many features, e.g. ctrl-t, ctrl-r, alt-c, etc.
sudo snap install tree
sudo snap install bitwarden


# Mullvad
wget -P ~/Downloads/ --content-disposition https://mullvad.net/download/app/deb/latest && sudo apt install -y ~/Downloads/MullvadVPN*md64.deb


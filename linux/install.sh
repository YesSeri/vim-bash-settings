curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
cargo install cargo-binstall
cargo binstall bat
#
# Replacement for find. 
cargo binstall fd-find
cargo binstall lsd


# Install from source to get latest version. apt version is missing many features, e.g. ctrl-t, ctrl-r, alt-c, etc.
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo apt install curl neovim build-essential pandoc qbittorrent wireshark ripgrep htop sox git zathura nnn brightnessctl xclip complx-tools nautilus-dropbox zathura
sudo snap install audacity bitwarden code datagrip discord emacs fbreader firefox intellij-idea-ultimate krita musescore okular postman vlc

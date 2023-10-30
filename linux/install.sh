./subscripts/git-setup.sh
# install essentials
sudo apt install curl build-essential pandoc qbittorrent htop sox zathura nnn brightnessctl xclip nautilus-dropbox audacity musescore vlc vim
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install neovim
sudo snap install nvim --classic

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
PATH=$PATH:$HOME/.cargo/bin
# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.local/bin/
ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50

# Install binstall and rust programs
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall --no-confirm ripgrep fd-find zoxide --locked bat xh

# Install from source to get latest version. apt version is missing many features, e.g. ctrl-t, ctrl-r, alt-c, etc.
sudo snap install tree bitwarden

# Mullvad
wget -P ~/Downloads/ --content-disposition https://mullvad.net/download/app/deb/latest && sudo apt install -y ~/Downloads/MullvadVPN*md64.deb

# nvim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

./subscripts/lazygit.sh
$(./subscripts/dropbox.sh)

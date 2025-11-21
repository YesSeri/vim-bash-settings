{ config, pkgs, ... }:

let 
  user = "heze";
in
{
  users.users."${user}" = {
    isNormalUser = true;
    description = "Henrik Zenkert";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
        # jetbrains.rust-rover
	jq
	jujutsu
	nix-tree
	sshfs
        bat
        bitwarden-desktop
        brightnessctl
        curl
        fd
        fzf
        gcc
        gnumake
        htop
        neovim
        nixfmt-rfc-style
        nnn
        obsidian
        pcmanfm
        ripgrep
        ripgrep-all
        slack
        tealdeer
        tmux
        unzip
        vimHugeX
        vlc
        watchexec
        xclip
        zathura
        zip
        zoxide
	pavucontrol
	direnv
	bruno
	vscode-fhs
	teams-for-linux
	zed-editor
    ]; 
  };
}


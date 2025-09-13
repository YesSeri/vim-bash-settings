{ config, pkgs, ... }:

{
  users.users.heze = {
    isNormalUser = true;
    description = "Henrik Zenkert";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
        # audacity
        # direnv
        # discord
        # ffmpeg
        # lazygit
        # libreoffice-qt6-still
        # moonlight-qt
        # neovide
        # strawberry
        # vscode
        # yt-dlp
	jq
	jujutsu
	nix-tree
	rust-analyzer
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
        rust-analyzer
        rustup
        slack
        tealdeer
        tmux
        unzip
        vimHugeX
        vlc
        vscode-fhs
        watchexec
        xclip
        zathura
        zip
        zoxide
	pavucontrol
    ];

  };
}

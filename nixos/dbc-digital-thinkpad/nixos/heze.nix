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
        # jq
        # lazygit
        # libreoffice-qt6-still
        # moonlight-qt
        # neovide
        # strawberry
        # vscode
        # yt-dlp
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
        rust-analyzer
	sshfs
	jujutsu
    ];
  };
}

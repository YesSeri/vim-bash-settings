{ pkgs, unstable, ... }:
{
  users.users.henrik = {
    isNormalUser = true;
    description = "henrik";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];

    packages =
      with pkgs;
      [
        audacity
        bat
        bitwarden-desktop
        curl
        direnv
        discord
        dmenu
        fd
        ffmpeg
        fzf
        gcc
        gnumake
        strawberry
        htop
        jq
        lazygit
        libreoffice-qt6-still
        moonlight-qt
        neovide
        neovim
        nix-direnv
        nixfmt-rfc-style
        nnn
        nodejs_22
        pavucontrol
        pcmanfm
        qbittorrent
        ripgrep
        ripgrep-all
        rofi
        rustup
        steam
        syncthing
        tealdeer
        thunderbird
        tmux
        unzip
        vimHugeX
        vlc
        vscode
        watchexec
        xclip
        yt-dlp
        jetbrains.idea-community-bin
        zathura
        zed-editor
        zip
        zoxide
      ]
      ++ [ unstable.android-studio ];
  };
}

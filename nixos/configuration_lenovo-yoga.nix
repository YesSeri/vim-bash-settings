# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # UI
  environment.pathsToLink = [ "/libexec" ];

  services.xserver.xkb.variant = "";
  services.xserver.xkb.options = "grp:alt_shift_toggle";
  services.xserver.xkb.layout = "us,dk";
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3 = {
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };

  services.displayManager.defaultSession = "none+i3";

  ## Enable the X11 windowing system.
  #services.xserver.enable = true;
  #
  ## Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.printing.enable = true;

  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
  users.users.henrik = {
    isNormalUser = true;
    hashedPassword = "$6$qs7X8fwSnwe9U82U$qfnbpeB9MJ.Fa0FuS65VsUM13fdNkgdL39DJUh5fzwcziixng4u8HfqPVS1iTtDvNvyhQFaODkTbAx3GesLrE0";
    description = "henrik";
    extraGroups = [
      "vboxusers"
      "networkmanager"
      "wheel"
      "audio"
      "video"
    ];

    packages = with pkgs; [
      audacity
      bat
      bitwarden-desktop
      curl
      # evince
      eza
      fd
      ffmpeg
      fzf
      # gcc
      # gnumake
      htop
      inetutils
      jq
      lazygit
      libreoffice-qt6-still
      mullvad
      mullvad-vpn
      neovim
      nixfmt-rfc-style
      nnn
      nodejs_22
      pavucontrol
      qbittorrent
      ripgrep
      ripgrep-all
      rustup
      # steam
      tealdeer
      tmux
      unzip
      vimHugeX
      vlc
      vscode
      watchexec
      xclip
      yt-dlp
      zathura
      zip
      sshfs
      zoxide
    ];
  };
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  #   localNetworkGameTransfers.openFirewall = true;
  # };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "henrik";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables = {
    TERM = "alacritty";
    EDITOR = "vim";
    VISUAL = "vim";
    PAGER = "bat";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    LESS = "-FRX";
    FZF_DEFAULT_COMMAND = "fd --type f";
    FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    # acpid
    # alsa-utils
    emacs
    git
    # pulseaudio
    brightnessctl
    python3
    tree
    wget
  ];

  services.openssh.enable = false;
  services.openssh.settings.PasswordAuthentication = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  system.copySystemConfiguration = true;

  networking.networkmanager.enable = true;
  virtualisation.virtualbox.host.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # services.acpid.enable = true;

}

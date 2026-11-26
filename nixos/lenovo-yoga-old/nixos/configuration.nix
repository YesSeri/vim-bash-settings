# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./qemu.nix
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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
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
      pamixer
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

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
  services.tailscale.enable = true;

  nix.settings.extra-substituters = [
    "https://cache.numtide.com"
  ];
  
  nix.settings.extra-trusted-public-keys = [
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];

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
      "docker"
    ];

    packages = with pkgs; [
      bat
      bitwarden-desktop
      curl
      eza
      fd
      ffmpeg
      htop
      inetutils
      jq
      lazygit
      libreoffice-fresh
      neovim
      nixfmt
      nnn
      nodejs_22
      pavucontrol
      qbittorrent
      ripgrep
      ripgrep-all
      rustup
      tealdeer
      tmux
      unzip
      vim-full
      vlc
      vscode
      watchexec
      inputs.workmux.packages.${pkgs.stdenv.hostPlatform.system}.default
      xclip
      yt-dlp
      zathura
      zip
      zoxide

      btop
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
      direnv
      dust
      fzf
      gh
      hyperfine
      nix-output-monitor
      nvd
      shellcheck
      tokei
      uv
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "henrik";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
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
    freerdp
    git
    brightnessctl
    python3
    tree
    wget
  ];

  # laptop key events

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

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 50;
  };
  networking.networkmanager.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      max-jobs = "auto";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot.loader.systemd-boot.configurationLimit = 10;
  services.resolved.enable = true;
  networking.useHostResolvConf = false;

}

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
       ../../modules/steam.nix
      ./gnome.nix
      ./niri.nix
      ./openvpn.nix
      ./heze.nix
      ./nvidia.nix
      #./activation-logger.nix
      #./libvirt.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-e44fe054-0b7c-4d9c-a4bb-29d2b048be1d".device = "/dev/disk/by-uuid/e44fe054-0b7c-4d9c-a4bb-29d2b048be1d";
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
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
  services.xserver = {
    enable = true;
    xkb.layout = "us,dk";
    xkb.options = "grp:alt_shift_toggle";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    bibata-cursors
    openvpn
    emacs
    git
    pulseaudio
    python3
    tree
    gnupg
    wget
  ];
  services.tailscale.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses; 
    enableSSHSupport = true;
  };
  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings = {
    secret-key-files = [ "/var/lib/nix/keys/heze-deploy.sec" ];
    trusted-substituters = [
      "https://nix-cache.dbccloud.dk/"
      "https://cache.nixos.org"
    ];
    require-sigs = true;
    trusted-public-keys = [
      "nix-cache.dbc.dk-1:kUWx19RceYRA1a+6+3ipRQOvwTORKZk+u0DZzI7Bdrs="
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  } // { 
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
  # boot.blacklistedKernelModules = [ "ucsi_acpi" "typec_ucsi" ];
  boot.kernelModules = [
    "typec"
    "typec_ucsi"
    "usb_power_delivery"
    "i915" 
  ];

}

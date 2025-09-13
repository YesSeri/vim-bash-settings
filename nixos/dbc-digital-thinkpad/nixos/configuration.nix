# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
       ../../modules/fonts.nix
# ./kde-plasma.nix
       # ./gnome.nix
      ./niri.nix
      ./openvpn.nix
      ./heze.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-e44fe054-0b7c-4d9c-a4bb-29d2b048be1d".device = "/dev/disk/by-uuid/e44fe054-0b7c-4d9c-a4bb-29d2b048be1d";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
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


  # Configure keymap in X11
  services.xserver.xkb = {
     layout = "us";
     variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.



  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   alacritty
   openvpn
   emacs
   git
   pulseaudio
   python3
   tree
   gnupg
   wget
  ];
  programs.gnupg.agent = {
    enable = true;
    # pinentryPackage = "curses";  # or "gtk2", "qt", etc
    pinentryPackage = pkgs.pinentry-curses;  # or pkgs.pinentry-qt, -gnome3, etc.
    enableSSHSupport = true;    # if you want SSH key support
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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

  boot.kernelModules = [ "i915" ];


#   networking.resolvconf.enable = true;
#   services.openvpn.servers.linux = {
#     autoStart = false;
#     config = builtins.readFile /home/heze/vpn/exheze/linux.ovpn;
#     updateResolvConf = true;
#   };

}

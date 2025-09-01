{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  services.calibre-web = {
    enable = true;
    listen = {
      ip = "127.0.0.1";
      port = 8084;
    };
    options = {
      calibreLibrary       = "/srv/calibre/library";
      enableBookUploading  = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/calibre/library 0755 calibre-web calibre-web -"
  ];

  users.users.henrikserver = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHiRCWw5NBxM1t6JzPUqQDYFblta+w/ojsi1ajGVyH6v"
    ];
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    hashedPassword = "$6$i4CeIlsCZ1tFGjPC$BODfLwkVQakTrGgFHlgvYyTZDPuKGJc20pFfho/KIyMbFuYmAnZkhM2zRBuh4XADufEZAoLTSZDbCWJ/9uqC31";
    packages = with pkgs; [
      calibre
      curl
      ffmpeg
      git
      hostmap
      openssl
      python313
      tmux
      tree
      unzip
      wget
      zip
    ];
  };

  services.syncthing = {
    enable = true;
    user = "syncthing";
    dataDir = "/var/lib/syncthing";
    configDir = "/var/lib/syncthing/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
  };

  environment.systemPackages = with pkgs; [
    cpufrequtils
    lm_sensors
    powertop
    tlp
    vim
  ];

  boot.loader.grub.devices = [ "/dev/sda" ];
  boot.loader.grub.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8083 ];
  # networking.firewall.allowedTCPPorts = [ 5001 8083 22 ];
  networking.hostName = "henrikserver-slow-nixos";
  networking.wireless.enable = false;
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.enable = true;
  services.avahi.enable = false;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.pipewire.enable = false;
  services.printing.enable = false;
  swapDevices = [ { device = "/swapfile"; size = 2048; } ];
  system.stateVersion = "25.05";
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';
  users.users.henrikserver.linger = true;
  networking.firewall.allowedUDPPorts = [ 41641 ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-public-keys = [
    "my-cache:JPW4QZXdPrFc1DmRBC5mDknlWGgaxuBRwLKJ9iEzl+M="
  ];
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."hostmap" = {
      listen = [{ addr = "0.0.0.0"; port = 5001; }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
  
    virtualHosts."calibre" = {
      listen = [{ addr = "0.0.0.0"; port = 8083; }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8084";
        proxyWebsockets = true;
      };
    };
  };

}

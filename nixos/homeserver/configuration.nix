{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ./modules/calibre.nix
    ./modules/nginx.nix
  ];

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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.enable = true;
  services.avahi.enable = false;
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore 
  '';
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.pipewire.enable = false;
  services.printing.enable = false;
  swapDevices = [ { device = "/swapfile"; size = 2048; } ];
  system.stateVersion = "25.05";
  nix.settings.trusted-public-keys = [
    "my-cache:JPW4QZXdPrFc1DmRBC5mDknlWGgaxuBRwLKJ9iEzl+M="
  ];

  systemd.services.hostmap = {
    description = "hostmap maps nix store paths to git revisions";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hostmap}/bin/hostmap";
      Restart = "always";
      User = "nobody";
    };
  };

}

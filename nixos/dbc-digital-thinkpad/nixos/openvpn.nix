{ config, pkgs, ... }:


{

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
        networkmanagerapplet   # provides nm-applet and nm-connection-editor
  ];
}

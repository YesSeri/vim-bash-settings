{ config, lib, pkgs, ... }:
{

  programs.niri.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty fuzzel waybar mako xwayland grim slurp wl-clipboard swaylock
  ];
  environment.etc."environment.d/10-wayland.conf".text = ''
    NIXOS_OZONE_WL=1
  '';
}


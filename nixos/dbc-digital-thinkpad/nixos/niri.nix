{ config, lib, pkgs, ... }:
{

  programs.niri.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings.default_session = {
  #     command = "${pkgs.niri}/bin/niri-session";
  #     user = "heze";
  #   };
  # };

  # Wayland desktop essentials
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
}


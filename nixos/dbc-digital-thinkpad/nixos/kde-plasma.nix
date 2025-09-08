{ config, pkgs, ... }:
{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "heze";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;            # still useful for X11 apps/config
  services.xserver.videoDrivers = [ "nvidia" ];

}

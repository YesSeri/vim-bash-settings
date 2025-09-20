{ config, pkgs, ... }:

{
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "heze";
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.enable = true;
  # systemd.services."autovt@tty1".enable = false;
  # systemd.services."getty@tty1".enable = false;
}

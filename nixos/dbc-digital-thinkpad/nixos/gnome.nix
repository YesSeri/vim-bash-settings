{ config, pkgs, ... }:

{
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "heze";
  # systemd.services."autovt@tty1".enable = false;
  # systemd.services."getty@tty1".enable = false;

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.enable = true;

  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [
    pkgs.gsettings-desktop-schemas
  ];

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.interface]
    cursor-theme='Bibata-Modern-Ice'
    cursor-size=24
  '';
}

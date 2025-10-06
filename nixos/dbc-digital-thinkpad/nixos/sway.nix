# { config, lib, pkgs, ... }:
# {
#   programs.sway = {
#     enable = true;
#     wrapperFeatures.gtk = true;
#     extraPackages = with pkgs; [
#       alacritty fuzzel waybar mako grim slurp wl-clipboard swaylock
#     ];
#   };
# 
#   services.xserver.enable = true;
#   services.xserver.displayManager.gdm = {
#     enable = true;
#     wayland = true;
#   };
#   services.displayManager.defaultSession = "sway";
# 
#   xdg.portal.enable = true;
#   xdg.portal.wlr.enable = true;
#   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
# 
#   environment.etc."environment.d/10-wayland.conf".text = ''
#     NIXOS_OZONE_WL=1
#   '';
# }
 
# { config, lib, pkgs, ... }:
# {
#   environment.systemPackages = with pkgs; [
#     grim # screenshot functionality
#     slurp # screenshot functionality
#     wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
#     mako # notification system developed by swaywm maintainer
#   ];
# 
#   # Enable the gnome-keyring secrets vault. 
#   # Will be exposed through DBus to programs willing to store secrets.
#   services.gnome.gnome-keyring.enable = true;
# 
#   # enable Sway window manager
#   programs.sway = {
#     enable = true;
#     wrapperFeatures.gtk = true;
#   };
#   services.greetd = {                                                      
#     enable = true;                                                         
#     settings = {                                                           
#       default_session = {                                                  
#         command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
#         user = "greeter";                                                  
#       };                                                                   
#     };                                                                     
#   };
# }
# { config, lib, pkgs, ... }:
# {
#   programs.sway = {
#     enable = true;
#     wrapperFeatures.gtk = true;
#     extraPackages = with pkgs; [
#       alacritty fuzzel waybar mako grim slurp wl-clipboard swaylock
#     ];
#   };
# 
#   services.xserver.enable = true;
#   services.xserver.displayManager.gdm = {
#     enable = true;
#     wayland = true;
#   };
# 
#   # Correct path:
#   services.xserver.displayManager.defaultSession = "sway";
# 
#   xdg.portal.enable = true;
#   xdg.portal.wlr.enable = true;
#   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
# 
#   environment.etc."environment.d/10-wayland.conf".text = ''
#     NIXOS_OZONE_WL=1
#   '';
# }

{ config, lib, pkgs, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      alacritty fuzzel  mako grim slurp wl-clipboard swaylock
    ];
  };

programs.waybar.enable = true;
    services.xserver.videoDrivers = lib.mkForce [ "nouveau" ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.displayManager.defaultSession = "sway";

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.etc."environment.d/10-wayland.conf".text = ''
    NIXOS_OZONE_WL=1
  '';
}


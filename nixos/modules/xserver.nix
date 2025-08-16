{ pkgs, ... }:
{
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  services.xserver.enable = true;
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };
  # services.xserver.displayManager.sessionCommands = ''
  # xset s off         # Disable screen saver
  # xset -dpms         # Disable Display Power Management Signaling
  # xset s noblank     # Disable screen blanking
  # '';
}

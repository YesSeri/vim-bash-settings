{ ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "Sun 03:00";
    flake = "path:/etc/nixos#nixos";
    allowReboot = false;
    persistent = true;
  };
  nix.gc = {
    automatic = true;
    dates = "Sun 04:00";
    options = "--delete-older-than 30d";
    persistent = true;
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
}

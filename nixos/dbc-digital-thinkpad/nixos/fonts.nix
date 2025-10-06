{ config, pkgs, ...} :
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      nerd-fonts.fira-code
    ];
    fontconfig.enable = true;
  };
  environment.systemPackages = with pkgs; [ papirus-icon-theme ];
}

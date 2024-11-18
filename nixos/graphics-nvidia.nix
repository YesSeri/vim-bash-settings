{ config, pkgs, ... }:

# source: https://nixos.wiki/wiki/Nvidia
{
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];
  #hardware.opengl.enable = true;
  #  hardware.nvidia = {
  #    # experimental
  #    powerManagement.enable = true;
  #    open = false;
  #    nvidiaSettings = true;
  #    package = config.boot.kernelPackages.nvidiaPackages.stable;
  #  };
}

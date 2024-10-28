{ config, pkgs, ... }:

# source: https://nixos.wiki/wiki/Nvidia
{
	hardware.opengl.enable = true;
	services.xserver.videoDrivers = ["nvidia" "amdgpu"];
	hardware.nvidia = {
		# experimental
		powerManagement.enable = true;
		open = false;
		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}

{ config, pkgs, ... }:
{
	programs.xwayland.enable = true;

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};
	 environment.systemPackages = with pkgs; [
	    xwayland-satellite  # >= 0.7
	  ];
}

# echo "$DISPLAY"           # should now be like :0 or :1
# pgrep -a xwayland-satellite
# pgrep -a Xwayland
# steam --verbose

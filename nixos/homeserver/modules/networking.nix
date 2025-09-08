{ ... }:
{

  networking.firewall.allowedTCPPorts = [ 22 80 8083 ];
  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.hostName = "henrikserver-slow-nixos";
  networking.wireless.enable = false;

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}

{ ... }:
{




  # If using NetworkManager:
  # If using Tailscale and you don’t want it to hijack DNS:
  networking.firewall.allowedTCPPorts = [ 22 80 8083 ];
  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  networking.hostName = "henrikserver-slow-nixos";
  networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

  networking.wireless.enable = false;

  services.resolved.enable = true;
  services.resolved.fallbackDns = [ "1.1.1.1" "9.9.9.9" ];

  services.tailscale.extraUpFlags = [ "--accept-dns=false" ];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };
}

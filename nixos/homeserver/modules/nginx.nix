{ ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."hostmap" = {
      listen = [{ addr = "0.0.0.0"; port = 80;}];
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
      };
    };
  
    virtualHosts."calibre" = {
      listen = [{ addr = "0.0.0.0"; port = 8083; }];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8084";
        proxyWebsockets = true;
      };
    };
  };
}

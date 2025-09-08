{ ... }:
{
  environment.etc."nginx/htpasswd-copyparty".text = ''
    henrik:$2y$12$y/4mouHRIO56XLjmYZImBOKebmyzRRLvgfvJsJ4uZMUBQaN1xV9Iu
  '';
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
      locations."/copyparty/" = {
        alias = "/var/www/copyparty/";
        extraConfig = ''
          auth_basic "Restricted";
          auth_basic_user_file /etc/nginx/htpasswd-copyparty;

          autoindex on;                         # optional, remove if you don't want listing
          add_header X-Content-Type-Options nosniff;
          add_header Cache-Control "no-store";
        '';
      };
      locations."/" = {
        proxyPass = "http://127.0.0.1:8084";
        proxyWebsockets = true;
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/www/copyparty 0755 henrikserver nginx -"
  ];
}

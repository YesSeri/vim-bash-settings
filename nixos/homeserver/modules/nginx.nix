{ config, ... }:
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
      # 1) Static + PHP under /copyparty/
      locations."/copyparty/" = {
        extraConfig = ''
          # Map URL /copyparty/* -> /var/www/copyparty/*
          root /var/www;
          index index.php index.html;

          auth_basic "Restricted";
          auth_basic_user_file /etc/nginx/htpasswd-copyparty;

          autoindex on;
          add_header X-Content-Type-Options nosniff;
          add_header Cache-Control "no-store";

          # Make .log/.txt render as text
          types { text/plain log txt; }
        '';
      };

      # 2) Execute PHP only for files actually present; no PATH_INFO
      locations."~ ^/copyparty/.+\\.php$" = {
        extraConfig = ''
          root /var/www;
          try_files $uri =404;

          include ${config.services.nginx.package}/conf/fastcgi_params;
          fastcgi_index index.php;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

          fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
        '';
      };
      # locations."/copyparty/" = {
      #   alias = "/var/www/copyparty/";
      #   extraConfig = ''
      #     auth_basic "Restricted";
      #     auth_basic_user_file /etc/nginx/htpasswd-copyparty;

      #     autoindex on;                         # optional, remove if you don't want listing
      #     add_header X-Content-Type-Options nosniff;
      #     add_header Cache-Control "no-store";

      #     fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
      #   '';
      # };
      locations."/" = {
        proxyPass = "http://127.0.0.1:8084";
        proxyWebsockets = true;
      };
    };
  };
  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      "pm" = "dynamic";            
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/www/copyparty 0755 henrikserver nginx -"
  ];
}

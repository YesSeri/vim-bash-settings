{ config, lib, pkgs, ... }:

{
  services.calibre-web = {
    enable = true;
    listen = {
      ip = "127.0.0.1";
      port = 8084;
    };
    options = {
      calibreLibrary       = "/srv/calibre/library";
      enableBookUploading  = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/calibre/library 0755 calibre-web calibre-web -"
  ];
}

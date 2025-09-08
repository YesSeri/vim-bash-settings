{ pkgs, ... }:
{
  users.users.henrikserver = with pkgs; {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHiRCWw5NBxM1t6JzPUqQDYFblta+w/ojsi1ajGVyH6v"
    ];
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = bash;
    hashedPassword = "$6$i4CeIlsCZ1tFGjPC$BODfLwkVQakTrGgFHlgvYyTZDPuKGJc20pFfho/KIyMbFuYmAnZkhM2zRBuh4XADufEZAoLTSZDbCWJ/9uqC31";
    packages = [
      calibre
      curl
      ffmpeg
      git
      hostmap
      openssl
      python313
      tmux
      tree
      unzip
      wget
      zip
    ];
  };
}

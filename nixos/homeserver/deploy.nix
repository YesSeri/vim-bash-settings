let
  flake = builtins.getFlake (toString ./.);
  system = "x86_64-linux";
  overlay-hostmap = (final: prev: {
    hostmap = (flake.inputs.hostmap.packages.${final.system}.default
               or flake.inputs.hostmap.defaultPackage.${final.system});
  });
  pkgs = import flake.inputs.nixpkgs {
    inherit system;
    overlays = [ overlay-hostmap ];
  };
in
{
  network.pkgs = pkgs;
  henriksserver = { ... }: {
    deployment.targetHost = "192.168.50.167";  
    deployment.targetUser = "root";
	deployment.secrets."secret-stuff" = {
	    source = "secret.txt";
	    destination = "/home/henrikserver/secret.txt";
	};

    imports = [
      ./hardware-configuration.nix
      ./configuration.nix
    ];
  };
}


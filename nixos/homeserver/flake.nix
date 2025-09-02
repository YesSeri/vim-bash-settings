{
  description = "NixOS for henrikserver-slow-nixos";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.hostmap.url = "github:YesSeri/hostmap?ref=minimal-counter";


  outputs = { self, nixpkgs, hostmap, ... }: {
    nixosConfigurations.henrikserver-slow-nixos =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
	  { 
	  nixpkgs.overlays = [
            (final: prev: {
              hostmap = hostmap.defaultPackage.${final.system or "x86_64-linux"};
            })
          ];
        }

        ];

      };
  };
}


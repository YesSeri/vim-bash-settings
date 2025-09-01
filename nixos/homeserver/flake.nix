{
  description = "NixOS for henrikserver-slow-nixos";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  inputs.hostmap.url = "github:YesSeri/hostmap";


  outputs = { self, nixpkgs }: {
    nixosConfigurations.henrikserver-slow-nixos =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
        ];
      };
  };
}


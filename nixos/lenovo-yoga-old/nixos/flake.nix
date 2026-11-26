{
  description = "old lenovo laptop nixos flake file";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    workmux.url = "github:raine/workmux";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
}

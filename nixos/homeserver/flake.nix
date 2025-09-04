{
  description = "NixOS for henrikserver-slow-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    hostmap.url = "github:YesSeri/hostmap?ref=minimal-counter";
  };

  outputs = { self, nixpkgs, hostmap, ... }:
  let
    system = "x86_64-linux";

    overlay-hostmap = final: prev: {
      hostmap = hostmap.packages.${final.system}.default
        or hostmap.defaultPackage.${final.system};
    };

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ overlay-hostmap ];
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations.henrikserver-slow-nixos =
      nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = pkgs;
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
        ];
      };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.alejandra
        pkgs.morph
      ];
    };
  };
}


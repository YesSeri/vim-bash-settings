nix build .#nixosConfigurations.henrikserver-slow-nixos.config.system.build.toplevel
nix copy --to ssh://root@henrikserver ./result
#ssh root@henrikserver ./result/bin/switch-to-configuration switch
STORE_PATH=$(nix path-info ./result)
ssh root@henrikserver $STORE_PATH/bin/switch-to-configuration switch



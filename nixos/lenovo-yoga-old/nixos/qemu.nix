{ config, pkgs, lib, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    qemu_kvm
  ];

  boot.kernelModules = [ "kvm-intel" ];
  users.users.henrik.extraGroups = [ "kvm" "libvirtd" ];
}


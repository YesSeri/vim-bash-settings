{ config, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      vhostUserPackages = [ ];
    };
  };

  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";

  users.users.heze = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "kvm"
    ];
  };

  programs.virt-manager.enable = true;
}


{ pkgs ? import <nixpkgs> {} }:
with pkgs;
[
    pkgs.tig
	pkgs.eza
	pkgs.php
	pkgs.btop
	pkgs.vimHugeX
	pkgs.lazygit
]



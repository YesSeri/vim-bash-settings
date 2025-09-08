{ lib, pkgs, ... }:
{
  system.extraSystemBuilderCmds =
    let
      activationLog = pkgs.writeShellScript "activation-log.sh" ''
        #!${pkgs.bash}/bin/bash
        set -euo pipefail

        A_USER="''${SUDO_USER:-$(${pkgs.coreutils}/bin/id -un || echo unknown)}"
        A_DIR="$(${pkgs.coreutils}/bin/dirname "''${BASH_SOURCE[0]}")"
        A_SYSTEM="$(${pkgs.coreutils}/bin/readlink -f "''${A_DIR}/..")"
        A_NOW="$(${pkgs.coreutils}/bin/date --rfc-3339=seconds 2>/dev/null || ${pkgs.coreutils}/bin/date '+%F %T%z')"
        A_ACTION="''${1:-activate}"

        echo "''${A_NOW};''${A_USER};''${A_SYSTEM};''${A_ACTION}" >> /var/activationlog.csv
        exec "''${A_SYSTEM}/bin/_switch-to-configuration" "''$@"
      '';
    in
    ''
      mv "$out/bin/switch-to-configuration" "$out/bin/_switch-to-configuration"
      ln -s ${activationLog} "$out/bin/switch-to-configuration"
    '';
}


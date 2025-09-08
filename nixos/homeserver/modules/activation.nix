{ config, pkgs, ... }:
{
  system.extraSystemBuilderCmds =
    let
      activationLog = pkgs.writeShellScript "activation-log.sh" ''
        A_USER="$(logname)"
        A_SYSTEM="$(cd "$( dirname "''${BASH_SOURCE[0]}" )/.." && pwd )"
        A_NOW="$(date --rfc-3339=second)"
        A_ACTION="$1"

        echo "$A_NOW;$A_USER;$A_SYSTEM;$A_ACTION" >>/var/activationlog.csv
        $A_SYSTEM/bin/_switch-to-configuration "$@"
      '';
    in
    ''
      mv $out/bin/switch-to-configuration $out/bin/_switch-to-configuration
      ln -s ${activationLog} $out/bin/switch-to-configuration
    '';
}

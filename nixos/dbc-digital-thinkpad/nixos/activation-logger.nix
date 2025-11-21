{ pkgs, ... }:
let
  activationLogFolder="/var/log/hostmap-activation-logs";
  activationLogFilename = "activations.csv";
in
{
  system.extraSystemBuilderCmds = let
    activationLog =
      with pkgs;
      writeShellScript "activation-log.sh" ''
        set -eu
        LOG_FOLDER='${activationLogFolder}'
  
        ${coreutils}/bin/mkdir -p "$LOG_FOLDER"
        ${coreutils}/bin/chown root:root "$LOG_FOLDER"
        ${coreutils}/bin/chmod 755 "$LOG_FOLDER"
  
        A_USER="$(${coreutils}/bin/logname 2>/dev/null || printf root)"
        A_SYSTEM="$(cd "$(${coreutils}/bin/dirname "''${BASH_SOURCE[0]}" )/.." && pwd )"
        A_NOW="$(${coreutils}/bin/date --rfc-3339=seconds)"
        A_ACTION="''${1:-unknown}"
  
        # Log to CSV
        LOG_FILE="$LOG_FOLDER/${activationLogFilename}"
	echo logfile: $LOG_FILE
        ${coreutils}/bin/printf '%s,%s,%s,%s\n' "$A_NOW" "$A_USER" "$A_SYSTEM" "$A_ACTION" 
        ${coreutils}/bin/printf '%s,%s,%s,%s\n' "$A_NOW" "$A_USER" "$A_SYSTEM" "$A_ACTION" >> "$LOG_FILE"
  
        exec "$A_SYSTEM/bin/__switch-to-configuration" "$@"
      '';
  in
  ''
    SYMLINK_LOCATION="$out/bin/__switch-to-configuration"
    if [ -e $SYMLINK_LOCATION ]; then 
      echo "activation-logger error:  $SYMLINK_LOCATION already exists"
      echo 'Do you have multiple things symlinking switch-to-configuration to __switch-to-configuration(two underscores)'
      exit 1
    fi
    mv $out/bin/switch-to-configuration $SYMLINK_LOCATION
    ln -s ${activationLog} $out/bin/switch-to-configuration
  '';
}


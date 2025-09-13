{
  config,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./graphics-nvidia.nix
    ../../modules/maintenance.nix
    ../../modules/xserver.nix
    ../../modules/henrik.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos";

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  environment.pathsToLink = [ "/libexec" ];

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.tailscale.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true;

  programs.steam = {
    enable = true;
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "henrik";

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    alacritty
    emacs
    git
    pulseaudio
    python3
    tree
    wget
  ];

  system.stateVersion = "24.05";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.sessionVariables = {
    TERM = "alacritty";
  };

  environment.variables = {
    EDITOR = "vim";
  };
}

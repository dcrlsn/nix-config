{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.shell.distrobox = {
    enable = lib.mkEnableOption "Distrobox container tool";
  };

  config = lib.mkIf config.custom.shell.distrobox.enable {
    environment.systemPackages = with pkgs; [
      distrobox
    ];
  };
}

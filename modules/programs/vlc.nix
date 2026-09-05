{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.vlc = {
    enable = lib.mkEnableOption "VLC media player";
  };

  config = lib.mkIf config.custom.programs.vlc.enable {
    environment.systemPackages = with pkgs; [
      vlc
    ];
  };
}

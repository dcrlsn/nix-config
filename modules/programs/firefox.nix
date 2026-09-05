{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.firefox = {
    enable = lib.mkEnableOption "Firefox web browser";
  };

  config = lib.mkIf config.custom.programs.firefox.enable {
    environment.systemPackages = with pkgs; [
      firefox
    ];
  };
}

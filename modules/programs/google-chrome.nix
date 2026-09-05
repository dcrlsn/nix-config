{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.google-chrome = {
    enable = lib.mkEnableOption "Google Chrome web browser";
  };

  config = lib.mkIf config.custom.programs.google-chrome.enable {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
  };
}

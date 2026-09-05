{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.slack = {
    enable = lib.mkEnableOption "Slack messaging client";
  };

  config = lib.mkIf config.custom.programs.slack.enable {
    environment.systemPackages = with pkgs; [
      slack
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.teams = {
    enable = lib.mkEnableOption "Microsoft Teams client (teams-for-linux)";
  };

  config = lib.mkIf config.custom.programs.teams.enable {
    environment.systemPackages = with pkgs; [
      teams-for-linux
    ];
  };
}

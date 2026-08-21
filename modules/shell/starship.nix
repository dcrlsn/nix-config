{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  options.custom.shell.starship = {
    enable = lib.mkEnableOption "Starship shell prompt";
  };

  config = lib.mkIf config.custom.shell.starship.enable {
    home-manager.users.${vars.user} = {
      programs.starship = {
        enable = true;
        settings = pkgs.lib.importTOML ./starship.toml;
      };
    };
  };
}

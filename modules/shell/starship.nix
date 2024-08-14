#
#  Terminal Prompt
#

{ vars, pkgs, ... }:

{
  home-manager.users.${vars.user} = {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };
  };
}

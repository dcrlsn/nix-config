#
#  Terminal Prompt
#

{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}

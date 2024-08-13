#
#  GTK
#

{ lib, config, pkgs, host, vars, ... }:

{
  home-manager.users.${vars.user} = {
    home = {
      pointerCursor = {
        gtk.enable = true;
        name = "Dracula-cursors";
        package = pkgs.dracula-theme;
        size = 16;
      };
    };
  };
}

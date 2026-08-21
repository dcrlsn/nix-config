{
  config,
  lib,
  pkgs,
  vars,
  themeColors,
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
        settings = pkgs.lib.recursiveUpdate (pkgs.lib.importTOML ./starship.toml) {
          palette = "tokyo";
          palettes.tokyo = {
            foreground = "#${themeColors.default.hex.fg}";
            background = "#${themeColors.default.hex.blue}";
            dark_bg = "#${themeColors.default.hex.bg_highlight}";
            darker_bg = "#${themeColors.default.hex.bg_dark}";
            text = "#${themeColors.default.hex.black}";
            cursor = "#${themeColors.default.hex.blue}";
            color1 = "#${themeColors.default.hex.cyan}";
            color2 = "#${themeColors.default.hex.blue}";
            color3 = "#${themeColors.default.hex.inactive}";
            color4 = "#${themeColors.default.hex.black}";
            color5 = "#${themeColors.default.hex.fg}";
            color6 = "#${themeColors.default.hex.cyan}";
            color7 = "#${themeColors.default.hex.red}";
            color8 = "#${themeColors.default.hex.yellow}";
            color9 = "#${themeColors.default.hex.purple}";
            color10 = "#${themeColors.default.hex.green}";
          };
        };
      };
    };
  };
}

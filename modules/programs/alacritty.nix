{
  config,
  lib,
  vars,
  themeColors,
  ...
}:

let
  c = themeColors.default.hex;
in
{
  options.custom.programs.alacritty = {
    enable = lib.mkEnableOption "Alacritty terminal emulator";
  };

  config = lib.mkIf config.custom.programs.alacritty.enable {
    home-manager.users.${vars.user} = {
      programs = {
        alacritty = {
          enable = true;
          settings = {
            window = {
              decorations = "Full";
            };
            font = {
              normal.family = "FiraCode Nerd Font";
              bold = {
                style = "Bold";
              };
              size = 10;
            };
            scrolling = {
              history = 0;
            };
            colors = {
              primary = {
                background = "#${c.bg}";
                foreground = "#${c.fg}";
              };
              cursor = {
                text = "#${c.bg}";
                cursor = "#${c.fg}";
              };
              normal = {
                black = "#${c.black}";
                red = "#${c.red}";
                green = "#${c.green}";
                yellow = "#${c.yellow}";
                blue = "#${c.blue}";
                magenta = "#${c.purple}";
                cyan = "#${c.cyan}";
                white = "#${c.white}";
              };
              bright = {
                black = "#${c.gray}";
                red = "#${c.red}";
                green = "#${c.green}";
                yellow = "#${c.yellow}";
                blue = "#${c.blue}";
                magenta = "#${c.purple}";
                cyan = "#${c.cyan}";
                white = "#${c.white}";
              };
            };
          };
        };
      };
    };
  };
}

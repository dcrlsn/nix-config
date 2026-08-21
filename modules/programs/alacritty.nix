{
  config,
  lib,
  vars,
  ...
}:

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
          };
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  vars,
  themeColors,
  ...
}:

let
  c = themeColors.default.hex;
in
{
  options.custom.shell.fastfetch = {
    enable = lib.mkEnableOption "Fastfetch system information tool";
  };

  config = lib.mkIf config.custom.shell.fastfetch.enable {
    home-manager.users.${vars.user} = {
      programs.fastfetch = {
        enable = true;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          logo = {
            padding = {
              top = 1;
              left = 1;
              right = 4;
            };
            color = {
              "1" = "#${c.blue}";
              "2" = "#${c.cyan}";
            };
          };
          display = {
            separator = " 󰄾 ";
          };
          modules = [
            {
              type = "title";
              color = {
                user = "#${c.blue}";
                at = "#${c.comment}";
                host = "#${c.cyan}";
              };
            }
            {
              type = "separator";
              string = "─";
              outputColor = "#${c.comment}";
            }
            {
              type = "os";
              key = "  os";
              keyColor = "#${c.blue}";
            }
            {
              type = "kernel";
              key = "  kernel";
              keyColor = "#${c.blue}";
            }
            {
              type = "uptime";
              key = "󰅐  uptime";
              keyColor = "#${c.cyan}";
            }
            {
              type = "display";
              key = "󰍹  display";
              keyColor = "#${c.cyan}";
            }
            {
              type = "shell";
              key = "  shell";
              keyColor = "#${c.purple}";
            }
            {
              type = "de";
              key = "󰇄  de";
              keyColor = "#${c.purple}";
            }
            {
              type = "terminal";
              key = "  term";
              keyColor = "#${c.purple}";
            }
            {
              type = "cpu";
              key = "󰍛  cpu";
              keyColor = "#${c.green}";
            }
            {
              type = "gpu";
              key = "󰢮  gpu";
              keyColor = "#${c.green}";
            }
            {
              type = "memory";
              key = "  memory";
              keyColor = "#${c.yellow}";
            }
            {
              type = "disk";
              key = "󰉉  disk";
              keyColor = "#${c.yellow}";
              folders = "/";
            }
            {
              type = "break";
            }
            {
              type = "colors";
              symbol = "circle";
            }
          ];
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  vars,
  inputs,
  themeColors,
  ...
}:

{
  options.custom.desktops.kde = {
    enable = lib.mkEnableOption "KDE Plasma 6 desktop environment";
  };

  config = lib.mkIf config.custom.desktops.kde.enable {
    programs = {
      zsh.enable = true;
      kdeconnect.enable = true;
    };

    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm.wayland.enable = true;
        defaultSession = "plasma";
      };
    };

    environment = {
      systemPackages = with pkgs.kdePackages; [
        packagekit-qt
      ];
      plasma6.excludePackages = with pkgs.kdePackages; [
        elisa
        kate
        konsole
        plasma-workspace-wallpapers
      ];
    };

    home-manager.users.${vars.user} = {
      imports = [
        (inputs.plasma-manager.homeModules.plasma-manager
          or inputs.plasma-manager.homeManagerModules.plasma-manager
        )
      ];
      programs.plasma = {
        enable = true;
        workspace = {
          colorScheme = "BreezeDark";
        };
        configFile = {
          "kdeglobals"."General"."AccentColor" = "${themeColors.default.rgb.blue}";
          "kdeglobals"."General"."LastUsedCustomAccentColor" = "${themeColors.default.rgb.blue}";
          "kdeglobals"."Icons"."Theme" = "breeze-dark";
        };
      };
    };
  };
}

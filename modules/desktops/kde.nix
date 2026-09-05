{
  config,
  lib,
  pkgs,
  vars,
  inputs,
  themeColors,
  ...
}:

let
  rgb = themeColors.default.rgb;
  tokyoNightColorScheme = pkgs.writeTextFile {
    name = "tokyo-night-kde-color-scheme";
    destination = "/share/color-schemes/TokyoNight.colors";
    text = ''
      [Colors:Window]
      BackgroundNormal=${rgb.bg}
      BackgroundAlternate=${rgb.bg_highlight or "41,46,66"}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:View]
      BackgroundNormal=${rgb.bg_dark or "22,22,30"}
      BackgroundAlternate=${rgb.bg}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Button]
      BackgroundNormal=${rgb.bg_highlight or "41,46,66"}
      BackgroundAlternate=${rgb.inactive or "65,72,104"}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Selection]
      BackgroundNormal=${rgb.blue}
      BackgroundAlternate=${rgb.inactive or "65,72,104"}
      ForegroundNormal=${rgb.black or "21,22,30"}
      ForegroundInactive=${rgb.text or "169,177,214"}
      ForegroundActive=${rgb.black or "21,22,30"}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Tooltip]
      BackgroundNormal=${rgb.bg_dark or "22,22,30"}
      BackgroundAlternate=${rgb.bg_highlight or "41,46,66"}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Complementary]
      BackgroundNormal=${rgb.bg_dark or "22,22,30"}
      BackgroundAlternate=${rgb.bg}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Header]
      BackgroundNormal=${rgb.bg}
      BackgroundAlternate=${rgb.bg_highlight or "41,46,66"}
      ForegroundNormal=${rgb.fg}
      ForegroundInactive=${rgb.gray or "86,95,137"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [Colors:Header][Inactive]
      BackgroundNormal=${rgb.bg_dark or "22,22,30"}
      BackgroundAlternate=${rgb.bg}
      ForegroundNormal=${rgb.gray or "86,95,137"}
      ForegroundInactive=${rgb.inactive or "65,72,104"}
      ForegroundActive=${rgb.blue}
      ForegroundLink=${rgb.cyan}
      ForegroundVisited=${rgb.purple}
      ForegroundNegative=${rgb.red}
      ForegroundNeutral=${rgb.yellow}
      ForegroundPositive=${rgb.green}
      DecorationFocus=${rgb.blue}
      DecorationHover=${rgb.cyan}

      [General]
      ColorScheme=TokyoNight
      Name=Tokyo Night
      shadeSortColumn=true

      [KDE]
      contrast=4

      [WM]
      activeBackground=${rgb.bg}
      activeForeground=${rgb.fg}
      inactiveBackground=${rgb.bg_dark or "22,22,30"}
      inactiveForeground=${rgb.gray or "86,95,137"}
    '';
  };

  sddmAurora = pkgs.stdenv.mkDerivation {
    pname = "sddm-aurora";
    version = "1.0.0";
    src = ../../themes/sddm-aurora;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sddm-aurora
      cp -r Main.qml metadata.desktop assets $out/share/sddm/themes/sddm-aurora/
      if [ -f preview.jpeg ]; then
        cp preview.jpeg $out/share/sddm/themes/sddm-aurora/
      fi
    '';
  };
in
{
  options.custom.desktops.kde = {
    enable = lib.mkEnableOption "KDE Plasma 6 desktop environment";
  };

  config = lib.mkIf config.custom.desktops.kde.enable {
    programs = {
      zsh.enable = true;
      kdeconnect.enable = true;
      dconf.enable = true;
    };

    services = {
      gvfs.enable = true;
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "sddm-aurora";
          extraPackages = with pkgs.kdePackages; [
            qt5compat
            qtsvg
          ];
        };
        defaultSession = "plasma";
      };
    };

    environment = {
      systemPackages = [
        pkgs.kdePackages.packagekit-qt
        pkgs.xclip
        pkgs.xdg-utils
        tokyoNightColorScheme
        sddmAurora
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
      xdg.dataFile."color-schemes/TokyoNight.colors".source =
        "${tokyoNightColorScheme}/share/color-schemes/TokyoNight.colors";
      programs.plasma = {
        enable = true;
        workspace = {
          colorScheme = "TokyoNight";
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

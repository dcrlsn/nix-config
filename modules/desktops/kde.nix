{ config, lib, pkgs, vars, inputs, ... }:

with lib;
{
  options = {
    kde = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.kde.enable) {
    programs = {
      zsh.enable = true;
      kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    };

  services = {
      xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "";
        displayManager = {
          sddm.wayland.enable = true;
          defaultSession = "plasma";
        };
        desktopManager.plasma5.enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs.libsForQt5; [
        bismuth # Dynamic Tiling
        packagekit-qt # Package Updater
	plasma-thunderbolt
      ];
      plasma5.excludePackages = with pkgs.libsForQt5; [
        elisa
        khelpcenter
        konsole
        oxygen
      ];
    };

    home-manager.users.${vars.user} = {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
      ];
      programs.plasma = {
        enable = true;
      };
    };
  };
}

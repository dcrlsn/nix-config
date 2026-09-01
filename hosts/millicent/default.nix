#
#  Specific system configuration settings for millicent (Framework 13)
#

{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enabled Custom Features (Dendritic Pattern)
  custom = {
    core.enable = true;
    desktops = {
      kde.enable = true;
      virtualization.docker.enable = true;
    };
    editors = {
      nvim.enable = true;
      antigravity.enable = true;
      vscode.enable = true;
      vscode-insiders.enable = true;
    };
    gaming = {
      steam.enable = true;
    };
    programs = {
      alacritty.enable = true;
      bambu-studio.enable = true;
      copilot.enable = true;
      discord.enable = true;
    };
    shell = {
      zsh.enable = true;
      tmux.enable = true;
      git.enable = true;
      starship.enable = true;
      direnv.enable = true;
    };
    theming.enable = true;
  };

  boot = {
    consoleLogLevel = 3;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
  };

  environment.systemPackages = with pkgs; [
    framework-tool
    fw-ectool
    displaylink
    gnome-network-displays
  ];

  services = {
    hardware.bolt.enable = true;
    autorandr.enable = true;
    xserver = {
      videoDrivers = [
        "displaylink"
        "modesetting"
      ];
      displayManager.sessionCommands = ''
        LEFT='DVI-I-1-1'
        CENTER='DP-3'
        RIGHT='DVI-I-2-2'
        ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --rotate left --output $LEFT --rotate left --left-of $CENTER --output $RIGHT --right-of $CENTER
      '';
    };
  };
}

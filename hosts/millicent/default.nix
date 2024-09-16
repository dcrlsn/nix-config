#
#  Specific system configuration settings for framework 13
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./millicent
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix

{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualization/docker.nix
  ] ++
  (import ../../modules/desktops/virtualization);

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

  environment = {
   systemPackages = with pkgs; [
     # Framework
     framework-tool
     fw-ectool
     # Dock
     displaylink
     # Chat... thisll probably move
     discord
     betterdiscordctl
     # 3D
     orca-slicer
     # Network Displays
     gnome-network-displays
    ];
  };

  # flatpak = {
  #   extraPackages = [
  #
  #   ];
  # };

  services = {
    hardware.bolt.enable = true;
    autorandr.enable = true;
    xserver = {
      enable = true;
      xkb = {
        variant = "";
	layout = "us";
      };
      videoDrivers = [ "displaylink" "modesetting"];
      desktopManager.plasma5.enable = true;
      displayManager.sessionCommands = ''
        LEFT='DVI-I-1-1'
        CENTER='DP-3'
        RIGHT='DVI-I-2-2'
        ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --rotate left --output $LEFT --rotate left --left-of $CENTER --output $RIGHT --right-of $CENTER
      '';
    };
    displayManager = {
      sddm.wayland.enable = true;
      defaultSession = "plasma";
    };
  };
}

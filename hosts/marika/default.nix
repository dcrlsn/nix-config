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
    xserver = {
      enable = true;
      xkb = {
	      layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia"];
      desktopManager.plasma6.enable = true;
    };
    
    displayManager = {
      defaultSession = "plasma";
    };
  };
}

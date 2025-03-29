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
  ] ++
  (
    import ../../modules/desktops/virtualization ++
    import ../../modules/gaming
  );

  boot = {
    consoleLogLevel = 3;
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        devices = [ "nodev" ];
        efiSupport = true;
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
      #orca-slicer
      # Network Displays
      gnome-network-displays
      # Games
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
    };
    desktopManager.plasma6.enable = true;
    displayManager = {
      defaultSession = "plasma";
    };
  };
}

#
#  Specific system configuration settings for marika
#

{ pkgs, ... }:

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
      cemu.enable = true;
    };
    programs = {
      alacritty.enable = true;
      orca-slicer.enable = true;
      bambu-studio.enable = true;
      copilot.enable = true;
      discord.enable = true;
      firefox.enable = true;
      google-chrome.enable = true;
      vlc.enable = true;
      libreoffice.enable = true;
      slack.enable = true;
      teams.enable = true;
    };
    shell = {
      zsh.enable = true;
      tmux.enable = true;
      git.enable = true;
      starship.enable = true;
      direnv.enable = true;
      distrobox.enable = true;
      fastfetch.enable = true;
      nixfmt.enable = true;
    };
    theming.enable = true;
  };

  boot = {
    consoleLogLevel = 3;
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        devices = [ "nodev" ];
        efiSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
  };

  environment.systemPackages = with pkgs; [
    spotify
    gnome-network-displays
    flatpak
    ngrok
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.bluetooth.enable = true;
}

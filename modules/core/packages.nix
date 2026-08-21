{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

lib.mkIf config.custom.core.enable {
  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      # Terminal & Utilities
      pkgs.${vars.terminal}
      xclip
      btop
      coreutils
      git
      gh
      gvfs
      killall
      lshw
      nano
      nix-tree
      pciutils
      tldr
      usbutils
      wget
      xdg-utils
      fastfetch

      # Video/Audio
      vlc

      # Apps
      appimage-run
      firefox
      google-chrome
      rustdesk-flutter

      # File Management
      p7zip
      rsync
      zip
      unzip

      # Work
      slack
      teams-for-linux

      # Development / Build
      distrobox
      gcc
      cmake
      ripgrep
      nixfmt
    ];
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
  };
}

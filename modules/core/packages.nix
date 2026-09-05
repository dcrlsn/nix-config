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
      btop
      coreutils
      git
      gh
      killall
      lshw
      nix-tree
      pciutils
      tldr
      usbutils
      wget

      # File Management
      p7zip
      rsync
      zip
      unzip

      # Development / Build
      gcc
      cmake
      ripgrep
    ];
  };

  programs = {
    nix-ld.enable = true;
  };
}

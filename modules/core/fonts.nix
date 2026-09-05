{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf config.custom.core.enable {
  fonts = {
    packages = with pkgs; [
      carlito # NixOS
      vegur # NixOS
      source-code-pro
      jetbrains-mono
      font-awesome # Icons
      corefonts # MS
      noto-fonts # Google + Unicode
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "FiraCode Nerd Font"
        "Fira Code"
        "Noto Sans Mono"
      ];
      sansSerif = [
        "Noto Sans"
        "DejaVu Sans"
      ];
      serif = [
        "Noto Serif"
        "DejaVu Serif"
      ];
      emoji = [
        "Noto Color Emoji"
      ];
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.gaming.cemu = {
    enable = lib.mkEnableOption "Cemu Wii U emulator";
  };

  config = lib.mkIf config.custom.gaming.cemu.enable {
    environment.systemPackages = with pkgs; [
      cemu
    ];
  };
}
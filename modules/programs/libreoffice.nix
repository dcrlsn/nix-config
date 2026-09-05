{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.libreoffice = {
    enable = lib.mkEnableOption "LibreOffice office suite";
  };

  config = lib.mkIf config.custom.programs.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-stable
    ];
  };
}

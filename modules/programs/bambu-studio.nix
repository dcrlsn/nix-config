{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.programs.bambu-studio = {
    enable = lib.mkEnableOption "Bambu Studio 3D slicer";
  };

  config = lib.mkIf config.custom.programs.bambu-studio.enable {
    environment.systemPackages = with pkgs; [
      bambu-studio
    ];
  };
}

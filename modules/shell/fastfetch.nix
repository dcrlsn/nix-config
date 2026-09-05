{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.shell.fastfetch = {
    enable = lib.mkEnableOption "Fastfetch system information tool";
  };

  config = lib.mkIf config.custom.shell.fastfetch.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.shell.nixfmt = {
    enable = lib.mkEnableOption "Nix code formatter";
  };

  config = lib.mkIf config.custom.shell.nixfmt.enable {
    environment.systemPackages = with pkgs; [
      nixfmt
    ];
  };
}

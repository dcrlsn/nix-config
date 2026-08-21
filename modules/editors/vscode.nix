{
  config,
  lib,
  pkgs,
  unstable ? pkgs,
  ...
}:

{
  options.custom.editors.vscode = {
    enable = lib.mkEnableOption "Visual Studio Code editor";
  };

  config = lib.mkIf config.custom.editors.vscode.enable {
    environment.systemPackages = [
      unstable.vscode
    ];
  };
}

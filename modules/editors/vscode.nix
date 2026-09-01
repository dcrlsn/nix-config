{
  config,
  lib,
  pkgs,
  unstable ? pkgs,
  vars,
  ...
}:

{
  options.custom.editors.vscode = {
    enable = lib.mkEnableOption "Visual Studio Code editor";
  };

  config = lib.mkIf config.custom.editors.vscode.enable {
    home-manager.users.${vars.user} = {
      programs.vscode = {
        enable = true;
        package = unstable.vscode;
        mutableExtensionsDir = true;
        profiles.default = {
          extensions = [
            pkgs.vscode-extensions.enkia.tokyo-night
          ];
          userSettings = {
            "workbench.colorTheme" = "Tokyo Night";
            "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
            "editor.fontLigatures" = true;
            "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
          };
        };
      };
    };
  };
}

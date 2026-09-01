{
  inputs,
  config,
  lib,
  pkgs,
  vars,
  ...
}:

let
  cfg = config.custom.editors.antigravity;
  antigravityPkgs = inputs.antigravity-nix.packages.${pkgs.system};
  baseAppPkg =
    if cfg.useFHS then
      antigravityPkgs.google-antigravity
    else
      antigravityPkgs.google-antigravity-no-fhs;
  idePkg =
    if cfg.useFHS then
      antigravityPkgs.google-antigravity-ide
    else
      antigravityPkgs.google-antigravity-ide-no-fhs;
  tokyoNightExt = pkgs.vscode-extensions.enkia.tokyo-night;
in
{
  options.custom.editors.antigravity = {
    enable = lib.mkEnableOption "Google Antigravity 2 (Base App, IDE, and CLI)";

    useFHS = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to use the standard FHS sandbox environment or auto-patchelfed non-FHS package for the GUI apps.";
    };

    enableIde = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include Antigravity IDE (antigravity-ide).";
    };

    enableCli = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Include Antigravity CLI (agy).";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      baseAppPkg
    ]
    ++ lib.optional cfg.enableIde idePkg
    ++ lib.optional cfg.enableCli antigravityPkgs.google-antigravity-cli;

    environment.shellAliases = lib.mkIf cfg.enableCli {
      anti = "antigravity-ide";
    };

    home-manager.users.${vars.user} = lib.mkIf cfg.enableIde {
      home.file = {
        ".antigravity-ide/extensions/${tokyoNightExt.vscodeExtUniqueId}".source =
          "${tokyoNightExt}/share/vscode/extensions/${tokyoNightExt.vscodeExtUniqueId}";
        ".config/Antigravity IDE/User/settings.json" = {
          text = builtins.toJSON {
            "workbench.colorTheme" = "Tokyo Night";
          };
          force = true;
        };
      };
    };
  };
}

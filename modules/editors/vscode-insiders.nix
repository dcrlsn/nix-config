{
  config,
  lib,
  pkgs,
  unstable ? pkgs,
  vars,
  ...
}:

let
  cfg = config.custom.editors.vscode-insiders;

  vscode-insiders =
    (unstable.vscode.override {
      isInsiders = true;
    }).overrideAttrs
      (oldAttrs: rec {
        pname = "vscode-insiders";
        version = "latest";
        src = pkgs.fetchurl {
          name = "VSCode_latest_linux-x64.tar.gz";
          url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
          hash = "sha256-301r3yE0UqWuADoPKyygharcXwEGj7LMDrlI5I//qDM=";
        };
        buildInputs = oldAttrs.buildInputs;
      });

  tokyoNightExt = pkgs.vscode-extensions.enkia.tokyo-night;
in
{
  options.custom.editors.vscode-insiders = {
    enable = lib.mkEnableOption "Visual Studio Code Insiders editor";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      vscode-insiders
    ];

    environment.shellAliases = {
      codei = "code-insiders";
    };

    home-manager.users.${vars.user} = { lib, ... }: {
      home.file = {
        ".vscode-insiders/extensions/${tokyoNightExt.vscodeExtUniqueId}".source =
          "${tokyoNightExt}/share/vscode/extensions/${tokyoNightExt.vscodeExtUniqueId}";
      };

      home.activation.setVSCodeInsidersSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                SETTINGS_DIR="$HOME/.config/Code - Insiders/User"
                SETTINGS_FILE="$SETTINGS_DIR/settings.json"
                $DRY_RUN_CMD mkdir -p "$SETTINGS_DIR"
                if [ -L "$SETTINGS_FILE" ]; then
                  $DRY_RUN_CMD rm -f "$SETTINGS_FILE"
                fi
                if [ ! -f "$SETTINGS_FILE" ]; then
                  $DRY_RUN_CMD cat << 'EOF' > "$SETTINGS_FILE"
        {
          "workbench.colorTheme": "Tokyo Night",
          "editor.fontFamily": "'FiraCode Nerd Font', 'Fira Code', monospace",
          "editor.fontLigatures": true,
          "terminal.integrated.fontFamily": "'FiraCode Nerd Font', 'Fira Code', monospace"
        }
        EOF
                  $DRY_RUN_CMD chmod 644 "$SETTINGS_FILE"
                fi
      '';
    };
  };
}

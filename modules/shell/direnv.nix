{
  config,
  lib,
  vars,
  ...
}:

{
  options.custom.shell.direnv = {
    enable = lib.mkEnableOption "Direnv and nix-direnv integration";
  };

  config = lib.mkIf config.custom.shell.direnv.enable {
    home-manager.users.${vars.user} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

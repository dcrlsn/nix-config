{ vars, pkgs, ... }:

{
  home-manager.users.${vars.user} = {
    programs.direnv = {
      enable = true;
      silent = false;
      loadInNixShell = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
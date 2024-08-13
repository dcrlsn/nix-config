{
  programs.direnv = {
    enable = true;
    silent = false;
    loadInNixShell = true;
    nix-direnv.enable = true;
#    enableZshIntegration = true;
  };
}

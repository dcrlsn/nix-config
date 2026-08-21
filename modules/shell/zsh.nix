{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  options.custom.shell.zsh = {
    enable = lib.mkEnableOption "Zsh shell configuration";
  };

  config = lib.mkIf config.custom.shell.zsh.enable {
    users.users.${vars.user} = {
      shell = pkgs.zsh;
    };

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "tmux"
        ];
      };

      shellInit = ''
        eval "$(starship init zsh)"
        eval "$(direnv hook zsh)"
        ZSH_TMUX_AUTOSTART=true
      '';
    };
  };
}

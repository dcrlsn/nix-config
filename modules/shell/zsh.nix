#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  programs = {
    zsh = {
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
        # I shouldnt have to do this...
	eval "$(starship init zsh)"
        # DirEnv Hook
        eval "$(direnv hook zsh)"
        ZSH_TMUX_AUTOSTART=true
      '';
    };
  };
}

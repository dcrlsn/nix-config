{ vars, pkgs, ... }:

{
  home-manager.users.${vars.user} = {
    programs.tmux = {
        enable = true;
        clock24 = true;
        mouse = true;
        baseIndex = 1;
        historyLimit = 10000;
        extraConfig = ''
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        '';
    };
  };
}

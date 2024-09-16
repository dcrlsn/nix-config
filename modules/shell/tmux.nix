{
  programs.tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
        # Mouse works as expected
        set-option -g mouse on
        # easy-to-remember split pane commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        # 1 based indexing for panes and windows
        set -g base-index 1
        setw -g pane-base-index 1
      '';
  };
}

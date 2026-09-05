{
  config,
  lib,
  vars,
  themeColors,
  ...
}:

let
  c = themeColors.default.hex;
in
{
  options.custom.shell.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf config.custom.shell.tmux.enable {
    home-manager.users.${vars.user} = {
      programs.tmux = {
        enable = true;
        clock24 = true;
        mouse = true;
        baseIndex = 1;
        historyLimit = 10000;
        terminal = "tmux-256color";
        extraConfig = ''
          # 24-bit color support
          set -as terminal-features ",xterm-256color:RGB"
          set -as terminal-overrides ",xterm-256color:Tc"

          # Keybindings
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          # Tokyo Night Theme Colors
          set -g status-interval 1
          set -g status-style "bg=#${c.bg_dark},fg=#${c.fg}"
          set -g status-left ""
          set -g status-right-length 100
          set -g status-right "#[fg=#${c.gray},bg=#${c.bg_dark}]%Y.%m.%d  #[fg=#${c.blue},bg=#${c.bg_dark}]%H:%M:%S  #[fg=#${c.purple},bg=#${c.bg_dark}]#[fg=#${c.black},bg=#${c.purple},bold] #h #[fg=#${c.purple},bg=#${c.bg_dark}]"

          set -g window-status-separator " "
          set -g window-status-format "#[fg=#${c.inactive},bg=#${c.bg_dark}]#[fg=#${c.fg_dark},bg=#${c.inactive}] #I #[fg=#${c.inactive},bg=#${c.bg_highlight}]#[fg=#${c.comment},bg=#${c.bg_highlight}] #W#{?window_zoomed_flag, 󰊓,} #[fg=#${c.bg_highlight},bg=#${c.bg_dark}]"
          set -g window-status-current-format "#[fg=#${c.blue},bg=#${c.bg_dark}]#[fg=#${c.black},bg=#${c.blue},bold] #I #[fg=#${c.blue},bg=#${c.bg_highlight}]#[fg=#${c.fg},bg=#${c.bg_highlight},bold] #W#{?window_zoomed_flag, 󰊓,} #[fg=#${c.bg_highlight},bg=#${c.bg_dark}]"

          # Pane borders
          set -g pane-border-style "fg=#${c.inactive}"
          set -g pane-active-border-style "fg=#${c.active}"

          # Message and prompt
          set -g message-style "bg=#${c.bg_highlight},fg=#${c.blue}"
          set -g message-command-style "bg=#${c.bg_highlight},fg=#${c.blue}"

          # Mode style (copy mode / selection)
          set -g mode-style "bg=#${c.bg_highlight},fg=#${c.yellow},bold"

          # Clock mode
          set -g clock-mode-colour "#${c.blue}"
        '';
      };
    };
  };
}

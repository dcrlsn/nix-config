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
          set -g status-style "bg=#${c.bg_dark},fg=#${c.fg}"
          set -g status-left "#[bg=#${c.blue},fg=#${c.black},bold] #S #[bg=#${c.bg_dark},fg=#${c.blue}] "
          set -g status-right "#[fg=#${c.gray},bg=#${c.bg_dark}] %Y-%m-%d #[fg=#${c.blue},bg=#${c.bg_dark}] %H:%M #[bg=#${c.purple},fg=#${c.black},bold] #h "

          set -g window-status-separator ""
          set -g window-status-style "bg=#${c.bg_dark},fg=#${c.comment}"
          set -g window-status-format " #I:#W#F "
          set -g window-status-current-style "bg=#${c.bg_highlight},fg=#${c.blue},bold"
          set -g window-status-current-format " #I:#W#F "

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

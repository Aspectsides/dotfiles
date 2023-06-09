{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.sidebar
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = with config.lib.base16.theme; ''
      # The statusbar
      set -g status-position bottom
      set -g base-index 1
      set -g pane-base-index 1
      set -g status-justify centre
      set -g status-bg colour0
      set -g status-fg colour5
      set -g status-left '#{prefix_highlight}#[fg=colour238]|―――――――――――――――――|'
      set -g status-right '#[fg=colour238]|―――――――――――――――――――――――|'
      set -g status-right-length 30
      set -g status-left-length 30

      # Change prefix to backtick
      unbind C-b
      set-option -g prefix `
      bind ` send-prefix

      # The Bindings
      unbind %
      bind h split-window -v
      unbind '"'
      bind v split-window -h
      bind r source-file ~/.config/tmux/tmux.conf
      unbind [
      bind escape copy-mode
      unbind p
      bind p paste-buffer
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "xsel -i" \; send-keys enter
      bind-key -T copy-mode-vi 'Y' send -X copy-pipe-and-cancel "tmux loadb -" \; send-keys enter
      
      # The messages
      set -g message-style fg=magenta,bg=colour236
      set -g message-command-style fg=blue,bg=black
      # keep window names fixed
            
      # loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity on
      set-option -g bell-action none
      
      # The modes
      setw -g clock-mode-colour colour135
      # setw -g mode-attr bold
      # setw -g mode-fg colour196
      # setw -g mode-bg colour238
      
      # The panes
      set -g pane-border-style fg=colour235
      set -g pane-active-border-style fg=colour5
      
      # setw -g window-status-current-fg colour2
      # setw -g window-status-current-bg default
      # setw -g window-status-current-attr none
      # setw -g window-status-current-format ' #W '
      
      # setw -g window-status-fg colour236
      # setw -g window-status-bg default
      # setw -g window-status-attr none
      # setw -g window-status-format '#[fg=colour8] #I #[fg=default]#W '
      setw -g window-status-format ' #W '
      
      # setw -g window-status-activity-bg default
      # setw -g window-status-activity-fg colour240
      # setw -g window-status-activity-attr none
      
      # setw -g window-status-bell-attr bold
      # setw -g window-status-bell-fg colour255
      # setw -g window-status-bell-bg colour1
      
      
      # -- PLUGINS -----------------------------
      
      # tmux-prefix-highlight
      set -g @prefix_highlight_fg 'colour0'
      set -g @prefix_highlight_bg 'colour5'
      set -g @prefix_highlight_copy_mode_attr 'fg=colour0,bg=color4'
      set -g @prefix_highlight_prefix_prompt 'C-c'
      set -g @prefix_highlight_show_copy_mode 'on'
    '';
  };
}

{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";

    extraConfig = ''
      set -g prefix C-s

      bind r source-file ~/.config/tmux/tmux.conf

      # bindings
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D

      bind-key v split-window -h
      bind-key s split-window -v

      bind-key q kill-window
      bind-key w kill-pane

      set-option -g status-position top
    '';

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "mocha"
          set -g @catppuccin_window_status_style "rounded"
          # Make the status line pretty and add some modules
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      }
      # {
      #   plugin = rose-pine;
      #   extraConfig = ''
      #     set -g @rose_pine_variant 'dawn'
      #     set -g @rose_pine_host 'on' # Enables hostname in the status bar
      #     set -g @rose_pine_user 'on' # Turn on the username component in the statusbar
      #     set -g @rose_pine_directory 'on' # Turn on the current folder component in the status bar
      #     set -g @rose_pine_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators
      #     set -g @rose_pine_bar_bg_disabled_color_option 'default'
      #
      #     set -g @rose_pine_only_windows 'on' # Leaves only the window module, for max focus and space
      #     set -g @rose_pine_disable_active_window_menu 'on' # Disables the menu that shows the active window on the left
      #
      #     set -g @rose_pine_default_window_behavior 'on' # Forces tmux default window list behaviour
      #     set -g @rose_pine_show_current_program 'on' # Forces tmux to show the current running program as window name
      #     set -g @rose_pine_show_pane_directory 'on' # Forces tmux to show the current directory as window name
      #
      #     set -g @rose_pine_left_separator ' > ' # The strings to use as separators are 1-space padded
      #     set -g @rose_pine_right_separator ' < ' # Accepts both normal chars & nerdfont icons
      #     set -g @rose_pine_field_separator ' | ' # Again, 1-space padding, it updates with prefix + I
      #     set -g @rose_pine_window_separator ' - ' # Replaces the default `:` between the window number and name
      #
      #     set -g @rose_pine_session_icon '' # Changes the default icon to the left of the session name
      #     set -g @rose_pine_current_window_icon '' # Changes the default icon to the left of the active window name
      #     set -g @rose_pine_folder_icon '' # Changes the default icon to the left of the current directory folder
      #     set -g @rose_pine_username_icon '' # Changes the default icon to the right of the hostname
      #     set -g @rose_pine_hostname_icon '󰒋' # Changes the default icon to the right of the hostname
      #     set -g @rose_pine_date_time_icon '󰃰' # Changes the default icon to the right of the date module
      #     set -g @rose_pine_window_status_separator "  " # Changes the default icon that appears between window names
      #
      #     set -g @rose_pine_prioritize_windows 'on' # Disables the right side functionality in a certain window count / terminal width
      #     set -g @rose_pine_width_to_hide '80' # Specify a terminal width to toggle off most of the right side functionality
      #     set -g @rose_pine_window_count '5' # Specify a number of windows, if there are more than the number, do the same as width_to_hide
      #   '';
      # }
    ];
  };
}

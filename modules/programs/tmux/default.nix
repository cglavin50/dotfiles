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

      # bindings
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key k select-pane -U
      bind-key j select-pane -D

      bind-key v split-window -h
      bind-key s split-window -v

      bind-key q kill-window
      bind-key w kill-pane
    '';
  };
}

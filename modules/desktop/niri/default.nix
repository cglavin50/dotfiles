{
  config,
  lib,
  ...
}: {
  programs.niri = {
    settings = {
      includes = [
        "./dms/alttab.kdl"
        "./dms/colors.kdl"
        "./dms/layout.kdl"
        "./dms/wpblur.kdl"
      ];

      prefer-no-csd = true;

      spawn-at-startup = [
        {argv = ["obsidian"];}
      ];

      gestures = {
        hot-corners.enable = false;
      };

      window-rules = [
        {
          # default layout
          matches = [{}];
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          # force obsidian in top workspace
          matches = [{app-id = "obsidian";}];
          open-on-workspace = "1";
        }
      ];

      layer-rules = [
        {
          matches = [
            {
              # namespace = "^noctalia-wallpaper.*$";
              namespace = "^quickshell$";
            }
          ];
          place-within-backdrop = true;
        }
      ];

      layout = {
        background-color = "transparent";
        default-column-width.proportion = 1.0;
      };

      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Ctrl+Alt+Return".action = spawn "kitty"; # terminal
        "Ctrl+E".action = spawn "nautilus"; # file explorer, should update
        # "Ctrl+E".action = spawn "ranger"; # file explorer, should update
        "Super+O".action = toggle-overview;
        "Super+F".action = fullscreen-window;
        "Ctrl+Q".action = close-window;
        "Super+D".action = spawn "fuzzel"; # launcher
        "Ctrl+Space".action = sh "dms ipc spotlight toggle";

        "Ctrl+H".action = focus-column-left;
        "Ctrl+L".action = focus-column-right;
        "Ctrl+J".action = focus-workspace-down;
        "Ctrl+K".action = focus-workspace-up;

        "Super+Minus".action = set-column-width "-10%";
        "Super+Plus".action = set-column-width "+10%";
        "Super+Shift+Minus".action = set-window-height "-10%";
        "Super+Shift+Plus".action = set-window-height "+10%";

        "Super+Shift+S".action = sh "dms screenshot";
        "Ctrl+Alt+Delete".action = sh "dms ipc lock lock";
      };
    };
  };

  # home.activation.niriTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #   if [ -f ~/.config/niri/config.kdl ]; then
  #     include dms/*.kdl >> ~/.config/niri/config.kdl
  #   fi
  # '';
}

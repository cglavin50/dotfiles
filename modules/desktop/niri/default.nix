{
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    settings = {
      # Note - comment this out for first run, as dms hasn't created the styling files yet
      includes = [
        "./dms/alttab.kdl"
        "./dms/colors.kdl"
        "./dms/layout.kdl"
        "./dms/wpblur.kdl"
      ];

      prefer-no-csd = true;

      cursor = {
        theme = "Bibata-Modern-Ice";
        hide-after-inactive-ms = 1000;
        size = 24;
      };

      input = {
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };

      outputs = {
        "ASUSTek COMPUTER INC ASUS VG34V W5LMTF038352" = {
          focus-at-startup = true;
          mode = {
            height = 1440;
            width = 3440;
            # niri matches refresh to the exact 3 decimals reported by
            # `niri msg outputs`. This monitor enumerates 164.999, not
            # 165.0 - the old value silently fell back to the panel's
            # 60Hz "preferred" mode on every reconnect.
            refresh = 164.999;
          };
          scale = 1.00;
          variable-refresh-rate = false; # temporarily off to isolate flicker cause
          position = {
            x = 0;
            y = 0;
          };
        };
        # DP-3 = {
        #   mode = {
        #     height = 1080;
        #     width = 1920;
        #   };
        #   scale = 1;
        #   position = {
        #     x = 2048; # using 1.25 scale
        #     y = 0;
        #   };
        # };
      };

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
          # obsidian: pin to workspace 1, but don't let notes sprawl
          # across the full 3440px - ~60% reads like a comfortable page.
          matches = [{app-id = "obsidian";}];
          open-on-workspace = "1";
          default-column-width.proportion = 0.6;
        }
        {
          # terminals: a single kitty/tmux column rarely needs more
          # than ~40% of an ultrawide; leaves room to scroll in a
          # browser or second terminal alongside it.
          matches = [{app-id = "kitty";}];
          default-column-width.proportion = 0.4;
        }
        {
          # zen browser: verify the real app-id with `niri msg windows`
          # after first launch (Firefox forks sometimes report
          # "zen-alpha" or "zen-twilight" instead of "zen").
          matches = [{app-id = "^[Zz]en.*";}];
          default-column-width.proportion = 0.55;
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
        # fallback for anything without an explicit rule above - half
        # width lets two columns share the screen by default instead
        # of every window claiming the whole ultrawide.
        default-column-width.proportion = 0.5;
        # quick-cycle sizes for Super+R below: third / half / two-thirds
        preset-column-widths = [
          {proportion = 0.33;}
          {proportion = 0.5;}
          {proportion = 0.67;}
          {proportion = 1.0;}
        ];
        # keep the active column centered once columns overflow the
        # screen width, instead of it hugging whichever edge you
        # scrolled from - much nicer on a wide monitor than the
        # default edge-anchored scroll.
        center-focused-column = "on-overflow";
        # a lone window on a workspace centers itself instead of
        # sitting flush against the left edge; the moment a second
        # column shows up, this stops applying and center-focused-column
        # above takes over (on-overflow: side-by-side unless they don't
        # both fit).
        always-center-single-column = true;
        gaps = 12;
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

        "Ctrl+Shift+H".action = move-column-left;
        "Ctrl+Shift+L".action = move-column-right;
        "Ctrl+Shift+J".action = move-window-down;
        "Ctrl+Shift+K".action = move-window-up;

        "Super+Minus".action = set-column-width "-10%";
        "Super+Equal".action = set-column-width "+10%";
        "Super+Shift+Minus".action = set-window-height "-10%";
        "Super+Shift+Equal".action = set-window-height "+10%";

        # cycle a column through the preset-column-widths above -
        # fast way to go terminal-narrow -> half -> browser-wide.
        "Super+R".action = switch-preset-column-width;
        "Super+Shift+F".action = maximize-column;
        "Super+C".action = center-column;

        # pull the neighboring column into this one as a second tile,
        # or kick the focused tile back out into its own column - lets
        # you stack e.g. two terminals side-by-side within one column
        # slot instead of always scrolling horizontally.
        "Ctrl+Alt+Shift+H".action = consume-or-expel-window-left;
        "Ctrl+Alt+Shift+L".action = consume-or-expel-window-right;

        "Super+Shift+S".action = sh "dms screenshot";
        "Super+T".action = sh "dms ipc call dash toggle \"media\"";
        "Super+Comma".action = sh "dms ipc call settings toggle";
        "Ctrl+Alt+Delete".action = sh "dms ipc lock lock";
        "Super+Shift+R".action =
          sh "wf-recorder -f ${config.home.homeDirectory}/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4";
        "Super+Shift+M".action = sh "dms ipc call theme toggle";
      };
    };
  };

  home.packages = with pkgs; [
    bibata-cursors
  ];
}

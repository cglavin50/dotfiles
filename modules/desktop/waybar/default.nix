{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = ./styles.css; # should import matugen theme

      settings = [{ 
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        layer = "top";
        name = "top-bar";
        position = "top";
        modules-left = [ 
          "mpris"
          "pulseaudio"
        ];
        modules-right = [
          "privacy"
          "network"
          "clock"
        ];
        modules-center = [
          "hyprland/workspaces"
          # "hyprland/window"
        ];

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          show-special = false;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format = "{icon} {name}";
          move-to-monitor = true;
          window-rewrite = {
            "class<firefox>" = "";
          };
          window-rewrite-default = "";
          format-icons = {
            "active" = "";
            "default" = "";
          };
        };
        "hyprland/window" = {
          format = "{}";
          icon = true; # use system icons from xdg-desktop
          separate-outputs = true;
          max-length = 70;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = "󰝟 ";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          scroll-step = 5;
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [ "" " " " " ];
          };
        };
        mpris = {
          format = "{player_icon}  {artist} : {title}";
          format-paused = "{player_icon} - {status_icon}  {artist}:{title}";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
          artist-len = 10;
          title-len = 20;
          player-icons = {
            default = "▶";
            mpv = "🎵";
            spotify = " ";
            firefox = " ";
            chromium = "  ";
          };
          status-icons = {
            paused = " ";
          };
        };
        network = {
          format-wifi = "󰖩 {essid}";
          format-disconnected = "󰖪 disconnected";
          format-ethernet = " ";
          tooltip = "true";
          tooltip-format = "{ipaddr}";
        };
        clock = {
          format = " {:%I:%M %p   %m/%d} ";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        tray = {
          icon-size = 12;
          spacing = 10;
        };
      }];
  };

  # start using systemd - was getting stability issues when launching from hyprland
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
  # systemd.user.services.waybar = {
  #   # description = "Waybar";
  #   wantedBy = [ "graphic-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.waybar}/bin/waybar";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #   };
  # };
}

{pkgs, ...}: {
  programs.dsearch.enable = true;

  programs.dankMaterialShell = {
    enable = true;

    niri = {
      enableKeybinds = true; # Sets static preset keybinds
      enableSpawn = true; # Auto-start DMS with niri and cliphist, if enabled
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    # plugins
    plugins = {
      BatteryAlert = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "AvengeMedia";
          repo = "dms-plugins";
          rev = "8fa7c5286171c66a209dd74e9a47d6e72ccfdad6";
          hash = "sha256-0RXRgUXXoX+C0q+drsShjx2rCTdmqFzOCR/1rGB/W2E=";
        };
      };
    };

    # anything we want to change from default settings
    default.settings = {
      # dynamic theming
      currentThemeName = "dynamic";
      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      blurWallpaperOnOverview = true;

      # dock config
      dockAutoHide = true;
      dockGroupByApp = true;
      dockOpenOnOverview = true;
      dockPosition = 1;
      dockBottomGa = 0;
      dockMargin = 0;
      dockIconSize = 40;
      dockIndicatorStyle = "line";
      dockBorderEnabled = true;
      dockBorderColor = "secondary";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;
    };
  };
}

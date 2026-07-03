{pkgs, ...}: {
  home.packages = with pkgs; [
    dms-shell
    quickshell
  ];

  xdg.configFile."dms/settings.json".text = builtins.toJSON {
    # dynamic theming
    currentThemeName = "dynamic";
    matugenScheme = "scheme-tonal-spot";
    runUserMatugenTemplates = true;
    blurWallpaperOnOverview = true;
    syncModeWithPortal = true;
    iconTheme = "System Default";
    borderColor = "surfaceText";
    widgetOutlineColor = "primary";
    gtkThemingEnabled = false;
    qtThemingEnabled = false;
    terminalsAlwaysDark = true;

    # font
    fontFamily = "FiraCode Nerd Font";
    monoFontFamily = "JetBrainsMonoNL Nerd Font Propo";

    # dock config
    showDock = true;
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

    # widget config
    widgetBackgroundColor = "sch";
    widgetColorMode = "colorful";
    use24HourClock = false;
    showSeconds = true;
    useFahrenheit = true;
    privacyShowMicIcon = false;
    privacyShowCameraIcon = false;
    privacyShowScreenShareIcon = false;
  };
}

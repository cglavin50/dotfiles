{...}: {
  programs.niri = {
    enable = true;
  };

  # enforce wayland use
  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}

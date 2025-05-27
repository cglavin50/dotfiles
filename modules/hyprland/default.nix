{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
  };

  # TODO migrate this, just scaffolding for now
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}

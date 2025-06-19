{
  config,
  pkgs,
  lib,
  ...
}: {
  # TODO need to re-organize this folder. Doing weird hybrid approach
  wayland.windowManager.hyprland = {
    enable = true;
  };

  # TODO migrate this, just scaffolding for now
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

  home.packages = with pkgs; [
    hyprpolkitagent
    # hyprpaper
  ];
}

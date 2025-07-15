{inputs, ...}: {
  xdg.configFile."matugen/config.toml".source = ./config.toml; # sys link config file
  xdg.configFile."matugen/templates".source = ./templates; # sys link our templates

  # programs.matugen = {
  #   enable = true;
  # };
}

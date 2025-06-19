{
  inputs,
  ...
}: {
  # TODO transfer this to home-manager module, couldn't get it to work initially
  xdg.configFile."matugen/config.toml".source=  ./config.toml; # sys link config file
  xdg.configFile."matugen/templates".source = ./templates; # sys link our templates

  programs.matugen = {
    enable = true;
  };
}

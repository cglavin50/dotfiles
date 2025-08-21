{
  config,
  pkgs,
  spicePkgs,
  ...
}: {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      keyboardShortcut
      shuffle
      powerBar
      skipStats
      songStats
      betterGenres
      adblock
      queueTime
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  # home.packages = with pkgs; [
  #   spotify-tui # including spotify-tui here for management
  # ];
}

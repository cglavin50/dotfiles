{
  config,
  pkgs,
  ...
}: {
  programs.nixcord = {
    enable = true; # also installs discord package
    vesktop.enable = true; # use vesktop
    config = {
      # enabledThemes = [ "~/.config/vesktop/themes/matugen.css" ];
      frameless = true;
      plugins = {
        hideAttachments.enable = true;
      };
    };
  };
}

{
  config,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;

    settings = {
      confirm_os_window_close = 0;
      background_opacity = 0.75;
      padding_width = 0;
      padding_height = 0;
      window_margin_width = 0;
      dynamic_padding = "no";
      line_spacing = 0;
      letter_spacing = 0;
      font_family = "JetBrainsMono Nerd Font";
      font_size = 11.0;
    };

    # matugen theme
    #  include colors.conf
    extraConfig = ''
      include dank-tabs.conf
      include dank-theme.conf

      # Allow ctrl+v to paste like ctrl+shift+v
      map ctrl+v paste_from_clipboard

      # Let apps (e.g. neovim's OSC52 clipboard provider) read/write the
      # clipboard without a confirmation prompt on every access.
      clipboard_control write-clipboard write-primary no-append read-clipboard read-primary
    '';
  };
}

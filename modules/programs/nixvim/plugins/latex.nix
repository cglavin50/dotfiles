# Single file to hold all the latex-related configurations for vim
{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      vimtex = {
        enable = true;
        settings = {
          view_method = "zathura";
        };
      };
      cmp-latex-symbols.enable = true; # add latex symbol support for cmp
    };
  };

  home.packages = with pkgs; [
    zathura
  ];
}

{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };  

  programs.ranger = {
    enable = true;


    plugins = [ 
      {
        name = "devicons";
        src = pkgs.fetchFromGitHub {
          owner = "alexanderjeurissen";
          repo = "ranger_devicons";
          rev = "1bcaff0";
          sha256 = "sha256-qvWqKVS4C5OO6bgETBlVDwcv4eamGlCUltjsBU3gAbA";
        };
      }
    ];

    mappings = {
      "E" = "edit";

      "zh" = "set show_hidden!";
    };

    extraConfig = ''
      default_linemode devicons

      set preview_images true
      set preview_images_method kitty

      mime ^text, has nvim, X, flag f = nvim -- "$@"

      mime ^text, has vim, X, flag f = vim -- "$@"
    '';
  };
}

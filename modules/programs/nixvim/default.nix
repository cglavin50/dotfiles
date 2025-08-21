{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./completion.nix

    ./plugins/autopairs.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/mini.nix
    ./plugins/conform.nix
    ./plugins/todo.nix
    ./plugins/lspconfig.nix
    ./plugins/treesitter.nix
    ./plugins/latex.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    luaLoader.enable = true;

    vimAlias = true;

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy.enable = true;
        xclip.enable = true;
      };
    };

    # theme
    # colorschemes.nightfox = {
    #   enable = true;
    #   flavor = "duskfox";
    # };
    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "moon";
        extend_background_behind_borders = true;
      };
    };
    # colorschemes.dracula-nvim.enable = true;
    # colorschemes.catppuccin.enable = true;
    # colorschemes.everforest.enable = true;
    # colorschemes.kanagawa.enable = true;
    # colorschemes.tokyonight = {
    #   enable = true;
    #   settings = {
    #     transparent = true;
    #     style = "moon";
    #   };
    # };

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "<leader>E";
        action = ":Ex<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];

    # misc plugins
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = ["nix" "yaml"];
        };
      };
      web-devicons.enable = true; # icons for plugins to use in ui
      sleuth.enable = true; # tabstop and shiftwidth
      indent-blankline.enable = true;
      markdown-preview.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      # Useful for getting pretty icons, but requires a Nerd Font.
      nvim-web-devicons # TODO: Figure out how to configure using this with telescope
    ];

    # TODO: Figure out where to move this
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapre
    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end
    '';

    # The line beneath this is called `modeline`. See `:help modeline`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapost
    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };

  # packages required by nvim
  home.packages = with pkgs; [
    clang
    ripgrep
    fd
    nodejs
  ];
}

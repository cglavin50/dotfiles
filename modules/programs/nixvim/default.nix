{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    vimAlias = true;

    clipboard = {
      register = "unnamedplus";
      providers = {
      	wl-copy.enable = true;
	xclip.enable = true;
      };
    };

    # theme
    colorschemes.catppuccin.enable = true;

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
        ensureInstalled = [ "nix" "yaml" ];
      };
      indent-blankline.enable = true;
      markdown-preview.enable = true;
    };
  };

  # packages required by nvim
  home.packages = with pkgs; [
    clang
    ripgrep
    fd
    nodejs
  ];
}

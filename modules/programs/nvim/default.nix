{
config, pkgs, ...
}:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

		# extraLuaConfig = ''
		# ${builtins.readFile ../../../config/nvim}
		# '';
	};

	# xdg.configFile."nvim" = {
	# 	source = config.lib.file.mkOutOfStoreSymlink "/home/cooper/.config/nvim";
	# };

  home.packages = with pkgs; [
    wl-clipboard
    tree-sitter
    lua54Packages.luarocks

    # required by treesitter
    ripgrep
    fd
  ];

programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # baseline stuff most LSPs/CLI tools want
    stdenv.cc.cc.lib   # libstdc++ - needed by tons of prebuilt binaries
    zlib
    openssl
    curl
    icu               # needed by nodejs-based tools (tsserver, etc.)
    libxml2
    bzip2
    xz
    util-linux
    # add more as things break, see step 4
  ];
}

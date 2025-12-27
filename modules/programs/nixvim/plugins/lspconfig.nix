{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        servers = {
          ts_ls.enable = true;
          pyright.enable = true;
          nil_ls = {
            enable = true;
            settings = {
              nix = {
                flake = {
                  autoArchive = false;
                };
              };
            };
          };
          tflint.enable = true;
          qmlls = {
            enable = true;
            cmd = ["qmlls" "-E"];
          };
          texlab.enable = true;
          gopls.enable = true;
          ansiblels.enable = false;
        };
      };

      # enable lsp-formatting on save
      lsp-format.enable = true;
    };
  };

  home.packages = with pkgs; [
    alejandra
    gopls
    nil
    # qt6.full # provides qmlls access. TODO: figure out how to narrow this down
  ];
}

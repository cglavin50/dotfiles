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
          tinymist = {
            enable = true;
            settings = {
              formatterMode = "typstyle";
              completion.triggerOnSnippetPlaceholders = true;
            };
            # For now, use typst-preview for preview features as it is not supported in nvim https://myriad-dreamin.github.io/tinymist/feature/preview.html#label-Neovim:
          };
        };
        keymaps = {
          ansiblels.enable = false;
        };
      };

      # enable lsp-formatting on save
      lsp-format.enable = true;
    };
  };

  # installing formatters here too, really need to clean this up
  home.packages = with pkgs; [
    alejandra
    black
    isort
    gopls
    nil
    # qt6.full # provides qmlls access. TODO: figure out how to narrow this down
  ];
}

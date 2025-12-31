# Typst-related plugins
{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      typst-vim = {
        enable = true;
        # See settings https://github.com/kaarmu/typst.vim/?tab=readme-ov-file#options
        settings = {
          pdf_viewer = "zathura";
          conceal = 1;
        };
      };

      # TODO: convert everything to tinymist for centralized management, handled via lsp
      typst-preview = {
        enable = true;
        settings = {
          dependencies_bin = {
            tinymist = "tinymist";
            websocat = "websocat";
          };
          # invert_colors = "auto";
          follow_cursor = false;
          open_cmd = "zen %s -p coop --class=typst-preview";
        };
        luaConfig.post = ''
          vim.api.nvim_create_autocmd('FileType', {
              pattern = 'typst',
              callback = function()
                local map = vim.keymap.set

                map('n', '<leader>tp', '<cmd>TypstPreviewToggle<cr>', { buffer = true, silent = true, desc = "[T]ypst [P]review" })
                map('n', '<leader>ts', '<cmd>TypstPreviewSync<cr>', { buffer = true, silent = true, desc = "[T]ypst Preview [S]ync"})
                map('n', '<leader>tr', '<cmd>TypstPreview<cr>', { buffer = true, silent = true, desc = "[T]ypst Preview" })
              end,
            })
        '';
      };
    };
  };

  home.packages = with pkgs; [
    zathura
    tinymist
    websocat
  ];
}

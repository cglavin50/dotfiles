{
  programs.nixvim = {
    opts.completeopt = ["menu" "menuone"];

    # completion sources
    plugins = {
      luasnip.enable = true; # lua snip for nvim-cmp

      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "luasnip"; }
          { 
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          ];

          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end"; # use LuaSnip

            mapping = {
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-y>" = "cmp.mapping.confirm { select = true }";
            };
        };
      };
    };
  };
}

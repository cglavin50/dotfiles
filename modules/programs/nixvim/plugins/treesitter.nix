{pkgs, ...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      settings = {
        auto_install = false;
        ensure_installed = [
          "bash"
          "c"
          "caddy"
          "lua"
          "typescript"
          "javascript"
          "css"
          "terraform"
          "markdown"
          "markdown_inline"
          "nix"
          "qmljs"
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "go"
          "gomod"
          "gosum"
          "json"
          "latex"
        ];
        highlight.enable = true;
      };
    };
  };
}

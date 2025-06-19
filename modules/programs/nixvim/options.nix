{
  programs.nixvim = {
  globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
      updatetime = 100; # Faster completion

      # Line numbers
      relativenumber = true; # Relative line numbers
      number = true; # display absolute line number of current line

      ignorecase = true; # remove case-sensitive on search
      cursorline = false;
      cursorcolumn = false;
      signcolumn = "yes";

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true; # Expand tab to space in insert
      autoindent = true;

      wrap = true;
    };
  };
}


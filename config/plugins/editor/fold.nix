{ ... }:
{
  opts = {
    foldenable = true;
    foldcolumn = "1";
    foldlevel = 99;
    foldlevelstart = 99;
    fillchars = {
      foldopen = "";
      foldclose = "";
      fold = " ";
      foldsep = " ";
      diff = "╱";
      eob = " ";
    };
  };

  plugins = {
    nvim-ufo = {
      enable = true;
      settings = {
        open_fold_hl_timeout = 150;
        # close_fold_kinds_for_ft = { };
        provider_selector = # lua
          ''
            function(bufnr, filetype, buftype)
              return {
                "lsp",
                "indent",
                -- "treesitter",
              }
            end
          '';

      };
    };
  };
}

{ ... }:
{
  plugins = {
    # sqlite-lua = {
    #   enable = true;
    # };

    yanky = {
      enable = true;
      settings = {
        # ring = {
        #   storage = "shada"; # shada, sqlite or memory (default: shada)
        # };
        system_clipboard = {
          sync_with_ring = false;
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" "x" "v" ];
      key = "y";
      action = "<Plug>(YankyYank)";
      options.silent = true;
      options.desc = "Yank Text";
    }
    {
      mode = [ "n" "x" "v" ];
      key = "p";
      action = "<Plug>(YankyPutAfter)";
      options.silent = true;
      options.desc = "Put Text After Cursor";
    }
    {
      mode = [ "n" "x" "v" ];
      key = "P";
      action = "<Plug>(YankyPutBefore)";
      options.silent = true;
      options.desc = "Put Text Before Cursor";
    }
    {
      mode = [ "n" "x" "v" ];
      key = "gp";
      action = "<Plug>(YankyGPutAfter)";
      options.silent = true;
      options.desc = "Put Text After Selection";
    }
    {
      mode = [ "n" "x" "v" ];
      key = "gP";
      action = "<Plug>(YankyGPutBefore)";
      options.silent = true;
      options.desc = "Put Text Before Selection";
    }
    {
      mode = "n";
      key = "]y";
      action = "<Plug>(YankyNextEntry)";
      options.silent = true;
      options.desc = "Yank Next Entry";
    }
    {
      mode = "n";
      key = "[y";
      action = "<Plug>(YankyPreviousEntry)";
      options.silent = true;
      options.desc = "Yank Previous Entry";
    }
  ]
  ++ [
    {
      mode = "v";
      key = "p"; # paste
      action = ''"_dP'';
      options.desc = "Clipboard: paste but keep the 'yank' value";
      options.silent = true;
    }
  ];
}

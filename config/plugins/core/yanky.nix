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
      mode = [
        "n"
        "x"
      ];
      key = "y";
      action = "<Plug>(YankyYank)";
      options.silent = true;
      options.desc = "Yank Text";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "p";
      action = "<Plug>(YankyPutAfter)";
      options.silent = true;
      options.desc = "Put Text After Cursor";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "P";
      action = "<Plug>(YankyPutBefore)";
      options.silent = true;
      options.desc = "Put Text Before Cursor";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "gp";
      action = "<Plug>(YankyGPutAfter)";
      options.silent = true;
      options.desc = "Put Text After Selection";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "gP";
      action = "<Plug>(YankyGPutBefore)";
      options.silent = true;
      options.desc = "Put Text Before Selection";
    }
    {
      mode = "n";
      key = "]y";
      action = "<Plug>(YankyCycleForward)";
      options.silent = true;
      options.desc = "Cycle Forward Through Yank History";
    }
    {
      mode = "n";
      key = "[y";
      action = "<Plug>(YankyCycleBackward)";
      options.silent = true;
      options.desc = "Cycle Backward Through Yank History";
    }
  ];
}

{ config, pkgs, ... }:
{
  plugins = {
    mini = {
      enable = true;
      # modules = { };
    };

    snacks = {
      enable = true;
    };

    snacks = {
      settings = {
        bufdelete = {
          enabled = true;
        };
        dim = {
          enabled = true;
        };
        # bigfile = {
        #   enabled = true;
        # };
        notifier = {
          enabled = true;
          # timeout = 3000;
        };
        # quickfile = {
        #   enabled = false;
        # };
        # statuscolumn = {
        #   enabled = false;
        # };
        words = {
          debounce = 100;
          enabled = true;
        };
        toggle = {
          enabled = true;
        };
      };
    };
  };

  autoCmd = [
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          -- Override print to use snacks for `:=` command
          vim.print = function(...)
            Snacks.debug.inspect(...)
          end
        end
      '';
    }
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          Snacks.toggle.inlay_hints():map("<localleader><localleader>uh", { silent = true, desc = "Toggle Inlay Hints" })
          Snacks.toggle.diagnostics():map("<localleader><localleader>ud")
          Snacks.toggle.dim():map("<localleader><localleader>uD", { silent = true, desc = "Toggle Dim" })
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<localleader><localleader>uw")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<localleader><localleader>uc")
        end
      '';
    }
  ];

  keymaps = [
    # --------------------------------------------------------------------------------
    # Buffer: delete buffer
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<M-w>"; # Alt-w
      action = ":lua Snacks.bufdelete()<cr>";
      options.desc = "Close current buffer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>bdo";
      action = ":lua Snacks.bufdelete.other()<cr>";
      options.desc = "Close other buffers";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Notification
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<localleader>unh";
      action = ":lua Snacks.notifier.show_history()<cr>";
      options.desc = "Notification History";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<localleader><localleader><esc>";
      action = ":lua Snacks.notifier.hide()<cr>";
      options.desc = "Dismiss All Notification";
      options.silent = true;
    }
  ];
}

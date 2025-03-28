{ lib, vnix, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # Snacks modules
    # --------------------------------------------------------------------------------
    snacks.settings = {
      bufdelete = {
        enabled = true;
      };
      dim = {
        enabled = true;
      };
      notifier = {
        enabled = true;
        # timeout = 3000;
      };
      toggle = {
        enabled = true;
      };
    };

    which-key.luaConfig.post = vnix.lua.mkRequire' "which-key" "add" [
      {
        __unkeyed-1 = "<leader>un";
        group = "Notification";
        icon = "󰎟 ";
      }
    ];
  };

  autoCmd = [
    # --------------------------------------------------------------------------------
    # Keymaps: Toggle UI
    # --------------------------------------------------------------------------------
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.dim():map("<leader>uf", { silent = true, desc = "Toggle Focus Dim" })
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
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
      action = lib.nixvim.mkRaw "function() Snacks.bufdelete() end";
      options.desc = "Close current buffer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = lib.nixvim.mkRaw "function() Snacks.bufdelete.other() end";
      options.desc = "Close other buffers";
      options.silent = true;
    }

    # --------------------------------------------------------------------------------
    # Notification
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>unh";
      action = lib.nixvim.mkRaw "function() Snacks.notifier.show_history() end";
      options.desc = "Notification History";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>und";
      action = lib.nixvim.mkRaw "function() Snacks.notifier.hide() end";
      options.desc = "Dismiss All Notification";
      options.silent = true;
    }
  ];
}

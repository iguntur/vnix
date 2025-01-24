{ luaRaw, ... }:
{
  plugins = {
    which-key = {
      enable = true;
      settings = {
        # notify = false;
        # preset = false;
        spec = [
          # { __unkeyed-1 = "<leader>bs"; group = "Sort"; icon = "󰒺 "; }
          {
            __unkeyed-1 = "<esc><esc>";
            hidden = true;
          }
          {
            __unkeyed-1 = "g";
            group = "Goto";
          }
          {
            __unkeyed-1 = "[";
            group = "Previous";
          }
          {
            __unkeyed-1 = "]";
            group = "Next";
          }

          # --------------------------------------------------------------------
          # With Leader
          # --------------------------------------------------------------------
          {
            __unkeyed-1 = "<leader><tab>";
            group = "Tab";
            icon = "󰌒 ";
          }
          {
            __unkeyed-1 = "<leader><leader>";
            group = "Leader";
            icon = "󱁐 ";
          }
          {
            __unkeyed-1 = "<leader>/";
            group = "Grep";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "Debug (DAP)";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Files";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
            icon = "󰊢 ";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
            icon = "󰿘 ";
          }
          {
            __unkeyed-1 = "<leader>n";
            group = "Neorg";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quit";
            icon = "󱑜 ";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Test";
            icon = "󰙨 ";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Windows";
            proxy = "<C-w>";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Trouble";
            icon = "󱓇 ";
          }
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>?";
      action = luaRaw.keymapRequire' "which-key" "show" { global = false; };
      options = {
        silent = true;
        desc = "Buffer Local Keymaps (which-key)";
      };
    }
  ];
}

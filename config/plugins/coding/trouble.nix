{ config, pkgs, ... }:
{
  plugins = {
    trouble = {
      enable = true;
      settings = { };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Diagnostics (Trouble)";
      };
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options = {
        silent = true;
        desc = "Toggle Buffer Diagnostics (Trouble)";
      };
    }
    {
      mode = "n";
      key = "<leader>xS";
      action = "<cmd>Trouble lsp toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle LSP Diagnostics (Trouble)";
      };
    }
    {
      mode = "n";
      key = "<leader>xL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Location List (Trouble)";
      };
    }
    {
      mode = "n";
      key = "<leader>xQ";
      action = "<cmd>Trouble qflist toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Quickfix List (Trouble)";
      };
    }
  ];
}

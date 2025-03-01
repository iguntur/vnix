{ config, pkgs, lib, ... }:
{
  keymaps = [
    # --------------------------------------------------------------------------------
    # Quickfix
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>lopen<cr>";
      options = {
        desc = "Location List";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>copen<cr>";
      options = {
        desc = "Quickfix List";
        silent = true;
      };
    }
  ]
  ++ lib.optionals (!config.plugins.trouble.enable) [
    {
      mode = "n";
      key = "[q";
      action.__raw = "vim.cmd.cprevious";
      options = {
        desc = "Previous Quickfix";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "]q";
      action.__raw = "vim.cmd.cnext";
      options = {
        desc = "Next Quickfix";
        silent = true;
      };
    }

    # --------------------------------------------------------------------------------
    # Quickfix list
    # --------------------------------------------------------------------------------
    {
      mode = "n";
      key = "<M-(>";
      action = "<cmd>cprevious<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<M-)>";
      action = "<cmd>cnext<cr>";
      options.silent = true;
    }
  ];
}

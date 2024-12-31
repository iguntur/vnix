{ config, pkgs, ... }:
{
  plugins = {
    marks = {
      enable = true;
      mappings = {
        next = "<M-L>"; # (Alt-Shift-L) Goes to next mark in buffer.
        prev = "<M-H>"; # (Alt-Shift-H) Goes to previous mark in buffer.
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>mqa";
      action = "<cmd>MarksQFListAll<cr>";
      options = {
        silent = true;
        desc = "Book[m]arks [q]uickfixlist [a]ll";
      };
    }
  ];
}

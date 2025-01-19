{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Lines
    # --------------------------------------------------------------------------------
    lsp-lines = {
      enable = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ul";
      action.__raw = "require('lsp_lines').toggle";
      options = {
        silent = true;
        desc = "Toggle LSP Lines";
      };
    }
  ];
}

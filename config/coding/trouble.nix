{ config, pkgs, lib, ... }:
let
  next_trouble = # lua
    ''
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end
    '';
  previous_trouble = # lua
    ''
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprevious)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end
    '';
in
{
  plugins = {
    trouble = {
      enable = true;
      settings = {
        modes = {
          lsp.win.position = "right";
        };
      };
    };
  };

  keymaps = lib.optionals config.plugins.trouble.enable [
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
    {
      mode = "n";
      key = "]q";
      action.__raw = next_trouble;
      options = { silent = true; desc = "Next trouble item"; };
    }
    {
      mode = "n";
      key = "<M-)>";
      action.__raw = next_trouble;
      options = { silent = true; desc = "Next trouble item"; };
    }
    {
      mode = "n";
      key = "[q";
      action.__raw = previous_trouble;
      options = { silent = true; desc = "Previous trouble item"; };
    }
    {
      mode = "n";
      key = "<M-(>";
      action.__raw = previous_trouble;
      options = { silent = true; desc = "Previous trouble item"; };
    }
  ];
}

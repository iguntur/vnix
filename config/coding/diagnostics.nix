{ lib, vnix, ... }:
let
  inherit (lib.nixvim) toLuaObject;
  icons = vnix.icons.diagnostics;
  lsplines-options = {
    virtual_text = {
      spacing = 4;
      source = "if_many";
      prefix = lib.nixvim.mkRaw ''
        function(diagnostic)
          for severity, icon in pairs(${toLuaObject icons}) do
            if diagnostic.severity == vim.diagnostic.severity[severity:upper()] then
              return icon
            end
          end
        end
      '';
    };
  };
in
{
  opts = {
    signcolumn = "auto:1";
  };

  diagnostics = {
    underline = true;
    update_in_insert = false;
    severity_sort = true;
    virtual_text = false;
    signs = {
      text = lib.nixvim.toRawKeys {
        "vim.diagnostic.severity.ERROR" = icons.Error;
        "vim.diagnostic.severity.WARN" = icons.Warn;
        "vim.diagnostic.severity.INFO" = icons.Info;
        "vim.diagnostic.severity.HINT" = icons.Hint;
      };
    };
  };

  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Lines
    # --------------------------------------------------------------------------------
    lsp-lines = {
      enable = true;
      luaConfig.post = ''
        vim.diagnostic.config({
          virtual_text = true,
          virtual_lines = false,
          -- virtual_lines = { only_current_line = true }
        })
      '';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ul";
      action = lib.nixvim.mkRaw ''
        function()
          local v = require('lsp_lines').toggle()
          if v then
            vim.diagnostic.config({ virtual_text = false })
          else
            vim.diagnostic.config(${toLuaObject lsplines-options})
          end
        end
      '';
      options = {
        silent = true;
        desc = "Toggle Switch Diagnostic Virtual Lines";
      };
    }
    {
      mode = "n";
      key = "<leader>uL";
      action.__raw = "require('lsp_lines').toggle";
      options = {
        silent = true;
        desc = "Toggle LSP Lines";
      };
    }
  ];
}

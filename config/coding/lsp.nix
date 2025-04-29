{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Core
    # --------------------------------------------------------------------------------
    lsp = {
      enable = true;
      # inlayHints = true;
      postConfig = ''
        do
          local opts = { bg = "None", bold = true }
          vim.api.nvim_set_hl(0, "LspReferenceText", opts)
          vim.api.nvim_set_hl(0, "LspReferenceRead", opts)
          vim.api.nvim_set_hl(0, "LspReferenceWrite", opts)
        end
      '';
    };

    # lsp.capabilities = "";
    # lsp.onAttach = "";

    # --------------------------------------------------------------------------------
    # LSP keymaps
    # --------------------------------------------------------------------------------
    lsp.keymaps = {
      silent = true;
      diagnostic = {
        "]d" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "[d" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
        # "<leader>[D" = {
        #   action = "open_float";
        #   desc = "Previous Diagnostic";
        # };
      };
      lspBuf = {
        "<leader>cr" = {
          action = "rename";
          desc = "Code Rename";
        };
        # "<leader>ca" = {
        #   # mode = [ "n" "v" ];
        #   action = "code_action";
        #   desc = "Code Action";
        # };

        K = {
          action = "hover";
          desc = "Hover";
        };
        gK = {
          action = "signature_help";
          desc = "Signature Help";
        };

        # gd = { action = "definition"; desc = "Goto Definition"; };
        # gD = { action = "declaration"; desc = "Goto Declaration"; };
        # gr = { action = "references"; desc = "Goto References"; nowait = true; };
        # gI = { action = "implementation"; desc = "Goto Implementation"; };
        # gt = { action = "type_definition"; desc = "Goto Type Definition"; };
      };
      extra =
        let
          goto = direction: severity: {
            __raw = # lua
              ''
                function()
                  vim.diagnostic.goto_${direction}({ severity = vim.diagnostic.severity.${severity} })
                end
              '';
          };
        in
        [
          {
            mode = "n";
            key = "<leader>lr";
            action = "<cmd>LspRestart<cr>";
            options = {
              silent = true;
              desc = "Restart Engine (LSP)";
            };
          }
          {
            mode = "n";
            key = "<leader>lI";
            action = "<cmd>LspInfo<cr>";
            options = {
              silent = true;
              desc = "Info (LSP)";
            };
          }
          {
            mode = "n";
            key = "<leader>ll";
            action = "<cmd>LspLog<cr>";
            options = {
              silent = true;
              desc = "Log (LSP)";
            };
          }
          # --------------------------------------------------------------------------------
          # Diagnostics
          # --------------------------------------------------------------------------------
          {
            mode = "n";
            key = "]e";
            action = goto "next" "ERROR";
            options = {
              silent = true;
              desc = "Next Error";
            };
          }
          {
            mode = "n";
            key = "[e";
            action = goto "prev" "ERROR";
            options = {
              silent = true;
              desc = "Previous Error";
            };
          }
          {
            mode = "n";
            key = "]w";
            action = goto "next" "WARN";
            options = {
              silent = true;
              desc = "Next Warning";
            };
          }
          {
            mode = "n";
            key = "[w";
            action = goto "prev" "WARN";
            options = {
              silent = true;
              desc = "Previous Warning";
            };
          }

          # --------------------------------------------------------------------------------
          # Rename file (via snacks)
          # --------------------------------------------------------------------------------
          {
            mode = "n";
            key = "<leader>fR";
            action.__raw = ''
              function()
                Snacks.rename.rename_file()
              end
            '';
            options = {
              silent = true;
              desc = "Rename File";
            };
          }

          # --------------------------------------------------------------------------------
          # LSP references (via snacks)
          # --------------------------------------------------------------------------------
          {
            mode = [
              "n"
              "t"
            ];
            key = "<M-n>"; # Alt-n
            action.__raw = ''
              function()
                Snacks.words.jump(vim.v.count1, true)
                vim.cmd.normal({ "zz", bang = true })
              end
            '';
            options = {
              silent = true;
              desc = "Next Reference";
            };
          }
          {
            mode = [
              "n"
              "t"
            ];
            key = "<M-p>"; # Alt-p
            action.__raw = ''
              function()
                Snacks.words.jump(-vim.v.count1, true)
                vim.cmd.normal({ "zz", bang = true })
              end
            '';
            options = {
              silent = true;
              desc = "Previous Reference";
            };
          }

          # --------------------------------------------------------------------------------
          # LSP inlay hints
          # --------------------------------------------------------------------------------
          {
            mode = [ "n" ];
            key = "<leader>uH";
            action.__raw = ''
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end
            '';
            options = {
              silent = true;
              desc = "Toggle inlay hints (global)";
            };
          }
          {
            mode = [ "n" ];
            key = "<leader>uh";
            action.__raw = ''
              function()
                local buffer = vim.api.nvim_get_current_buf()
                vim.lsp.inlay_hint.enable(
                  not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }),
                  { bufnr = buffer }
                )
              end
            '';
            options = {
              silent = true;
              desc = "Toggle inlay hints current buffer";
            };
          }
        ];
    };

    # --------------------------------------------------------------------------------
    # LSP servers
    # --------------------------------------------------------------------------------
    lsp.servers = {
      cmake.enable = true;
      emmet_ls.enable = true;
      jsonls.enable = true;
      # superhtml.enable = true;
      taplo.enable = true;

      yamlls = {
        enable = true;
        filetypes = [
          "yaml"
          "yml"
        ];
      };
    };

    # --------------------------------------------------------------------------------
    # LSP Signature
    # --------------------------------------------------------------------------------
    # TODO: lsp-signature = {
    #   enable = true;
    # };
  };

  extraPlugins = with pkgs.vimPlugins; [
    (pkgs.vimUtils.buildVimPlugin {
      name = "symbol-usage";
      src = pkgs.fetchFromGitHub {
        owner = "Wansmer";
        repo = "symbol-usage.nvim";
        rev = "main";
        hash = "sha256-VzliC8LARRXt/5yJN28K7UcM7sP7RQWW5CLw+a0mv0Q=";
      };
      dependencies = with pkgs.vimPlugins; [
        # ... 
      ];
    })
  ];

  extraConfigLua = lib.strings.concatStringsSep "\n" [
    # lua
    ''
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local res = {}

        local round_start = { "", "SymbolUsageRounding" }
        local round_end = { "", "SymbolUsageRounding" }

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions_content = symbol.stacked_count > 0
            and ("+%s"):format(symbol.stacked_count)
            or ""

        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          table.insert(res, round_start)
          table.insert(res, { "󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰳽 ", "SymbolUsageDef" })
          table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          table.insert(res, round_start)
          table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        if stacked_functions_content ~= "" then
          if #res > 0 then
            table.insert(res, { " " , "NonText" })
          end

          table.insert(res, round_start)
          table.insert(res, { " ", "SymbolUsageImpl" })
          table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
          table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        -- vt_position = "textwidth", -- "end_of_line",
        text_format = text_format,
      })
    ''
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>cu";
      action.__raw = "function() require('symbol-usage').refresh() end";
      options = {
        silent = true;
        desc = "Refresh Symbol Usage";
      };
    }
    {
      mode = "n";
      key = "<leader>uu";
      action.__raw = "function() require('symbol-usage').toggle() end";
      options = {
        silent = true;
        desc = "Toggle Symbol Usage";
      };
    }
    {
      mode = "n";
      key = "<leader>uU";
      action.__raw = "function() require('symbol-usage').toggle_globally() end";
      options = {
        silent = true;
        desc = "Toggle Symbol Usage (Global)";
      };
    }
  ];
}


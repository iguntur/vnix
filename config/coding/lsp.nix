{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Core
    # --------------------------------------------------------------------------------
    lsp = {
      enable = true;
      inlayHints = true;
      luaConfig.post = ''
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
              end
            '';
            options = {
              silent = true;
              desc = "Previous Reference";
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
}

{ lib, pkgs, ... }:
{
  plugins = {
    # --------------------------------------------------------------------------------
    # LSP Core
    # --------------------------------------------------------------------------------
    lsp = {
      enable = true;
      inlayHints = true;
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
      ansiblels.enable = true;
      bashls.enable = true;
      # ccls.enable = true;
      cssls.enable = true;
      clangd.enable = true;
      dockerls.enable = true;
      # earthlyls.enable = true;
      emmet_ls.enable = true;
      html.enable = true;
      htmx.enable = true;
      java_language_server.enable = false;
      jdtls.enable = false;
      jsonls.enable = true;
      # nushell.enable = true;
      ruff_lsp.enable = false;
      # superhtml.enable = true;
      tailwindcss.enable = true;
      taplo.enable = true;
      templ.enable = true;
      terraformls.enable = true;
      # veryl_ls.enable = true;
      zls.enable = false;

      helm_ls = {
        enable = true;
        filetypes = [ "helm" ];
      };

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

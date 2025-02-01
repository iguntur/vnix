{ config, lib, pkgs, vnix, ... }:
{
  plugins = {
    lsp.servers = {
      # eslint.enable = true;
      ts_ls = {
        enable = true;
        settings = rec {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all"; # 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayVariableTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHintsWhenTypeMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
          javascript = typescript;
          typescriptreact = typescript;
          javascriptreact = typescript;
        };
      };

      # LSP wrapper for typescript extension of vscode
      vtsls = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "javascript.jsx"
          "typescript"
          "typescriptreact"
          "typescript.tsx"
        ];
        settings = rec {
          complete_function_calls = true;
          typescript = {
            updateImportsOnFileMove.enabled = "always";
            suggest = {
              completeFunctionCalls = true;
            };
            inlayHints = {
              enumMemberValues.enabled = true;
              functionLikeReturnTypes.enabled = true;
              parameterNames.enabled = "literals";
              parameterTypes.enabled = true;
              propertyDeclarationTypes.enabled = true;
              variableTypes.enabled = false;
            };
          };
          javascript = typescript;
          vtsls = {
            enableMoveToFileCodeAction = true;
            autoUseWorkspaceTsdk = true;
            experimental = {
              maxInlayHintLength = 30;
              completion = {
                enableServerSideFuzzyMatch = true;
              };
            };
          };
        };
        onAttach.function = /* lua */ ''
          if client.name ~= "vtsls" then return end

          vim.keymap.set("n", "<leader>co", function() ${vnix.lsp.buf.action "source.organizeImports"} end, {buffer = bufnr, silent = true, desc = "Organize Imports"})
          vim.keymap.set("n", "<leader>cM", function() ${vnix.lsp.buf.action "source.addMissingImports.ts"} end, {buffer = bufnr, silent = true, desc = "Add Missing Imports"})
        '';
      };
    };

    # lsp.keymaps.extra = lib.optionals config.plugins.lsp.servers.vtsls.enable [
    #   {
    #     mode = "n";
    #     key = "";
    #     action = "";
    #     options.silent = true;
    #     options.desc = "";
    #   }
    # ];

    conform-nvim.settings.formatters_by_ft = rec {
      typescript = {
        __unkeyed-1 = "biome-check";
        __unkeyed-2 = "prettierd";
        __unkeyed-3 = "prettier";
        timeout_ms = 2000;
        stop_after_first = true;
      };
      javascript = typescript;
      javascriptreact = typescript;
      typescriptreact = typescript;
    };
  };

  extraPackages = with pkgs; [
    biome # Toolchain of the web
    nodePackages.prettier # Prettier is an opinionated code formatter
    prettierd # Prettier, as a daemon, for improved formatting speed
    typescript # Superset of JavaScript that compiles to clean JavaScript output
  ];
}

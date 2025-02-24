{ config, lib, pkgs, vnix, ... }:
{
  plugins = {
    typescript-tools = {
      enable = true;
      settings = {
        handlers = { };
        settings = {
          # https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all"; # 'none' | 'literals' | 'all'
            includeInlayParameterNameHintsWhenArgumentMatchesName = true;
            includeInlayVariableTypeHints = true;
            includeInlayFunctionParameterTypeHints = true;
            includeInlayVariableTypeHintsWhenTypeMatchesName = true;
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayEnumMemberValueHints = true;
            includeCompletionsForModuleExports = true;
            quotePreference = "auto";
          };
          # tsserver_format_options = {
          #   allowIncompleteCompletions = false;
          #   allowRenameOfImportPath = false;
          # };
        };
        on_attach.__raw = # lua
          ''
            function(client, bufnr)
              if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end

              ${vnix.lsp.onAttach_keymaps [
                {
                  key = "gD";
                  action = vnix.keymap.action_cmd "TSToolsGoToSourceDefinition";
                  options.desc = "Goto Source Definitions";
                }
                {
                  key = "gR";
                  action = vnix.keymap.action_cmd "TSToolsFileReferences";
                  options.desc = "Find All References";
                }

                {
                  key = "<leader>co";
                  action = vnix.keymap.action_cmd "TSToolsOrganizeImports";
                  options.desc = "Organize Imports";
                }
                {
                  key = "<leader>ci";
                  action = vnix.keymap.action_cmd "TSToolsAddMissingImports";
                  options.desc = "Add Missing Imports";
                }
                {
                  key = "<leader>cF";
                  action = vnix.keymap.action_cmd "TSToolsFixAll";
                  options.desc = "Fixes all fixable errors";
                }
                {
                  key = "<leader>cdd";
                  action = vnix.keymap.action_cmd "TSToolsRemoveUnused";
                  options.desc = "Remove all unused statements";
                }
                {
                  key = "<leader>cdi";
                  action = vnix.keymap.action_cmd "TSToolsRemoveUnusedImports";
                  options.desc = "Remove all unused imports";
                }
                {
                  key = "<leader>fR";
                  action = vnix.keymap.action_cmd "TSToolsRenameFile";
                  options.desc = "Rename file";
                }
              ]}
            end
          '';
      };
    };

    lsp.servers = {
      # eslint.enable = true;
      ts_ls = {
        enable = !config.plugins.typescript-tools.enable;
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
        enable = config.plugins.lsp.servers.ts_ls.enable;
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
          javascript = typescript;
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
        onAttach.function = vnix.lsp.onAttach_keymaps [
          {
            key = "<leader>co";
            action = vnix.lsp.buf.action_fn "source.organizeImports";
            options.desc = "Organize Imports";
          }
          {
            key = "<leader>cM";
            action = vnix.lsp.buf.action_fn "source.addMissingImports";
            options.desc = "Add Missing Imports";
          }
          {
            key = "gD";
            action = vnix.lsp.buf.execute_fn {
              command = "typescript.goToSourceDefinition";
              arguments = {
                __unkeyed-1.__raw = "vim.lsp.util.make_position_params().textDocument.uri";
                __unkeyed-2.__raw = "vim.lsp.util.make_position_params().position";
              };
            };
            options.desc = "Goto Source Definitions";
          }
          {
            key = "gR";
            action = vnix.lsp.buf.execute_fn {
              command = "typescript.findAllFileReferences";
              arguments = {
                __unkeyed-1.__raw = "vim.uri_from_bufnr(0)";
              };
            };
            options.desc = "Find All References";
          }
        ];
      };
    };

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

    which-key.settings.spec = lib.optionals config.plugins.typescript-tools.enable [
      {
        __unkeyed-1 = "<leader>cd";
        group = "Delete/Remove Unused";
      }
    ];
  };

  extraPackages = with pkgs; [
    # biome # Toolchain of the web
    nodePackages.prettier # Prettier is an opinionated code formatter
    prettierd # Prettier, as a daemon, for improved formatting speed
    typescript # Superset of JavaScript that compiles to clean JavaScript output
  ];
}

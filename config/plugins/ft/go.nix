{ lib, pkgs, ... }:
{
  plugins = {
    # ------------------------------------------------------------------------------
    # LSP
    # ------------------------------------------------------------------------------
    lsp.servers = {
      golangci_lint_ls.enable = true;
      gopls = {
        enable = true;
        filetypes = [ "go" "gomod" "gowork" "gosum" "gotmpl" ];
        settings.gopls = {
          gofumpt = true;
          completeUnimported = true;
          directoryFilters = [ "-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules" ];
          semanticTokens = true;
          staticcheck = true;
          usePlaceholders = true;
          analyses = {
            # fieldalignment = true;
            nilness = true;
            unusedparams = true;
            unusedwrite = true;
            useany = true;
          };
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
        };
        onAttach.function =
          # TODO: workaround: https://github.com/golang/go/issues/54531#issuecomment-1464982242
          # lua
          ''
            if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenModifiers = semantic.tokenModifiers,
                  tokenTypes = semantic.tokenTypes,
                },
                range = true,
              }
            end
          '';
      };
    };

    # ------------------------------------------------------------------------------
    # Formatters
    # ------------------------------------------------------------------------------
    conform-nvim.settings = {
      formatters_by_ft = {
        go = [
          "gofumpt"
          "goimports-reviser"
          "golines"
        ];
      };
      formatters = {
        golines = {
          prepend_args = [ "--max-len=120" ];
        };
      };
    };

    # ------------------------------------------------------------------------------
    # Test adapters
    # ------------------------------------------------------------------------------
    neotest.adapters = {
      golang = {
        enable = true;
        settings = {
          # go_test_args = [ "-v" "-race" "-count=1" "-timeout=60s" ]; # default
          dap_go_enabled = true;
        };
      };
    };

    # ------------------------------------------------------------------------------
    # Debug
    # ------------------------------------------------------------------------------
    dap.extensions = {
      dap-go.enable = true;
    };
  };

  extraPackages = with pkgs; [
    # Linter
    golangci-lint
    # golangci-lint-langserver

    # Formatters
    gofumpt # Stricter gofmt
    goimports-reviser # Right imports sorting & code formatting tool (goimports alternative)
    golines # Golang formatter that fixes long lines
  ];
}

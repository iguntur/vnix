{ lib, pkgs, ... }:
{
  plugins = {
    # ------------------------------------------------------------------------------
    # LSP
    # ------------------------------------------------------------------------------
    lsp.servers = {
      golangci_lint_ls.enable = true;
      gopls.enable = true;
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

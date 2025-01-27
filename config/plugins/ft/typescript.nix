{ lib, pkgs, ... }:
let
  formatter = {
    __unkeyed-1 = "biome-check";
    __unkeyed-2 = "prettierd";
    __unkeyed-3 = "prettier";
    timeout_ms = 2000;
    stop_after_first = true;
  };

  tsls-options = {
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
in
{
  plugins = {
    lsp.servers = {
      ts_ls = {
        enable = true;
        settings = {
          javascript = tsls-options;
          typescript = tsls-options;
          javascriptreact = tsls-options;
          typescriptreact = tsls-options;
        };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      javascript = formatter;
      typescript = formatter;
      javascriptreact = formatter;
      typescriptreact = formatter;
    };
  };

  extraPackages = with pkgs; [
    biome # Toolchain of the web
    nodePackages.prettier # Prettier is an opinionated code formatter
    prettierd # Prettier, as a daemon, for improved formatting speed
    typescript # Superset of JavaScript that compiles to clean JavaScript output
  ];
}

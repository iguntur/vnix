{ lib, pkgs, ... }:
{
  plugins = {
    # ------------------------------------------------------------------------------
    # LSP
    # ------------------------------------------------------------------------------
    lsp.servers = {
      # A fast, feature-rich static code analyzer & language server for Python
      # pylyzer = {
      #   enable = true;
      #   settings = { };
      # };

      # Static Type Checker for Python
      # pyright = {
      #   enable = true;
      #   settings = { };
      # };

      # Fork of the python-language-server project, maintained by the Spyder IDE team and the community
      pylsp = {
        enable = true;
        settings = { };
      };

      # An extremely fast Python linter and code formatter, written in Rust.
      ruff = {
        enable = true;
        settings = {
          # init_options.settings = {
          #   logLevel = "debug";
          # };
        };
      };
    };

    # ------------------------------------------------------------------------------
    # Formatter
    # ------------------------------------------------------------------------------
    # conform-nvim.settings.formatters_by_ft = {
    #   python = [
    #     "ruff_organize_imports"
    #     # "isort"
    #     # "black"
    #   ];
    # };

    # ------------------------------------------------------------------------------
    # Debug
    # ------------------------------------------------------------------------------
    dap-python = {
      enable = true;
      settings = { };
    };
  };

  extraPackages = with pkgs; [
    # Formatters
    # ruff # Extremely fast Python linter and code formatter
    # black # Uncompromising Python code formatter
    # isort # Python utility / library to sort Python imports
  ];
}

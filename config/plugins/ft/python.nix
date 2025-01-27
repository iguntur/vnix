{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers = {
      # A fast, feature-rich static code analyzer & language server for Python
      pylyzer = {
        enable = false;
      };

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
    };

    conform-nvim.settings.formatters_by_ft = {
      python = [
        "isort"
        "black"
      ];
    };
  };

  extraPackages = with pkgs; [
    black # Uncompromising Python code formatter
    isort # Python utility / library to sort Python imports
  ];
}

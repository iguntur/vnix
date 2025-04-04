{ lib, pkgs, ... }:
{
  plugins = {
    hmts.enable = true;
    lsp.servers = {
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> {}";
          diagnostic.suppress = [
            "sema-unused-def-lambda-noarg-formal"
            "sema-extra-with"
          ];
          # formatting.command = [
          #   # "nixfmt"
          #   "nixpkgs-fmt"
          # ];
        };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      nix = [
        "nixpkgs_fmt"
        "squeeze_blanks" # `cat -s`
      ];
    };
  };

  extraPackages = with pkgs; [
    # nixfmt-rfc-style # (nixfmt) Official formatter for Nix code
    nixpkgs-fmt # Nix code formatter for nixpkgs
  ];
}

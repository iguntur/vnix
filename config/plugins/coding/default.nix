{ lib, pkgs, ... }:
{
  imports = [
    ./aerial.nix
    ./cloak.nix
    ./database.nix
    ./debug.nix
    ./diagnostics.nix
    ./formatter.nix
    ./git.nix
    ./linter.nix
    ./lsp.nix
    ./nvim-context-vt.nix
    ./sibling-swap.nix
    ./test.nix
    ./treesitter.nix
    ./trouble.nix
  ];
}

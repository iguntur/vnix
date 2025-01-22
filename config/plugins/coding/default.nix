{ lib, pkgs, ... }:
{
  imports = [
    ./aerial.nix
    ./cloak.nix
    ./comments.nix
    ./database.nix
    ./debug.nix
    ./diagnostics.nix
    ./formatter.nix
    ./git.nix
    ./lazydev.nix
    ./linter.nix
    ./lsp.nix
    ./nvim-context-vt.nix
    ./sibling-swap.nix
    ./test.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./trouble.nix
  ];
}

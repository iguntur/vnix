{ lib, pkgs, ... }:
{
  imports = [
    ./aerial.nix
    ./analysis.nix
    ./cloak.nix
    ./comments.nix
    ./database.nix
    ./debug.nix
    ./diagnostics.nix
    ./formatter.nix
    ./git.nix
    ./lazydev.nix
    ./lsp.nix
    ./neogen.nix
    ./nvim-context-vt.nix
    ./refactoring.nix
    ./schemastore.nix
    ./sibling-swap.nix
    ./snippet.nix
    ./tailwind-tools.nix
    ./test.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./trouble.nix
  ];
}

{ lib, pkgs, ... }:
{
  imports = [
    ./aerial.nix
    ./analysis.nix
    ./avante.nix
    ./cloak.nix
    ./comments.nix
    ./debug.nix
    ./diagnostics.nix
    ./formatter.nix
    ./git.nix
    ./lazydev.nix
    ./lsp.nix
    ./lz-n.nix
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

  extraConfigLua = ''
    vim.keymap.set("n", "<M-b>", require("boolean-swap").toggle, {
    	silent = true,
    	desc = "Toggle swap boolean value",
    })
  '';
}

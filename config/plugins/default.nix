{
  imports = [
    # ./core
    # ./editor
    # ./ui
    # ./coding

    ./core.nix
    ./ui.nix

    ./aerial.nix
    ./bookmarks.nix
    ./cloak.nix
    ./cmp.nix
    ./diagnostics.nix
    ./file-tree.nix
    ./formatter.nix
    ./fzf.nix
    ./git.nix
    ./goto-linenumber.nix
    ./lsp.nix
    ./mini.nix
    ./move.nix
    ./nvim-context-vt.nix
    ./session.nix
    ./sibling-swap.nix
    ./text-case.nix
    ./treesitter.nix
    ./treesj.nix
    ./trouble.nix
    ./vim-table-mode.nix
    ./window.nix

    ./debug.nix
    ./database.nix
    ./linter.nix
    ./test.nix
  ];
}

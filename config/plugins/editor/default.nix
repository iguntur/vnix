{ config, pkgs, ... }:
{
  imports = [
    ./fold.nix
    ./move.nix
    ./split-join.nix
    ./text-case.nix
    # ./vim-table-mode.nix
  ];

  plugins = {
    indent-o-matic = {
      enable = true;
    };

    mini.modules = {
      ai = {
        n_lines = 500;
        # search_method = "cover_or_next";
      };

      pairs = {
        modes = {
          insert = true;
          command = true;
          terminal = false;
        };
      };

      surround = {
        # Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          add = "gsa"; # Add surrounding in Normal and Visual modes
          delete = "gsd"; # Delete surrounding
          find = "gsf"; # Find surrounding (to the right)
          find_left = "gsF"; # Find surrounding (to the left)
          highlight = "gsh"; # Highlight surrounding
          replace = "gsr"; # Replace surrounding
          update_n_lines = "gsn"; # Update `n_lines`
          # suffix_last = "l"; # Suffix to search with "prev" method
          # suffix_next = "n"; # Suffix to search with "next" method
        };
      };
    };
  };
}

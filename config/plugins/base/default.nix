{ config, pkgs, ... }:
{
  imports = [
    ./bookmarks.nix
    ./cmp.nix
    ./file-tree.nix
    ./flash.nix
    ./fzf.nix
    ./goto-linenumber.nix
    ./harpoon.nix
    ./session.nix
    ./undotree.nix
    ./which-key.nix
    ./yanky.nix
  ];

  plugins = {
    mini = {
      enable = true;
      # modules = { };
    };

    snacks = {
      enable = true;
    };

    snacks.settings = {
      bigfile = {
        enabled = true;
      };
      # quickfile = {
      #   enabled = false;
      # };
      # statuscolumn = {
      #   enabled = false;
      # };
      words = {
        debounce = 100;
        enabled = true;
      };
    };
  };

  autoCmd = [
    {
      event = [ "User" ];
      callback.__raw = ''
        function()
          -- Override print to use snacks for `:=` command
          vim.print = function(...)
            Snacks.debug.inspect(...)
          end
        end
      '';
    }
  ];

  # keymaps = [ ];
}

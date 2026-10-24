{ config, lib, vnix, ... }:
let
  inherit (vnix.lua) fnRaw mkRequire mkRequire';
  setup = a: b: fnRaw (mkRequire a b);
  setup' = a: b: c: fnRaw (mkRequire' a b c);
in
{
  plugins = {
    # join and split text line
    treesj = {
      # enable = true;
      settings = {
        use_default_keymaps = false;
        max_join_length = 180;
      };
    };

    mini.modules = {
      splitjoin = {
        mappings = {
          toggle = "gS";
        };
      };
    };
  };

  keymaps = lib.mkIf config.plugins.treesj.enable [
    {
      mode = "n";
      key = "<leader>cj";
      action = setup "treesj" "toggle";
      options = {
        silent = true;
        desc = "Toggle split and join code block";
      };
    }
    {
      mode = "n";
      key = "<leader>cJ";
      action = setup' "treesj" "toggle" { split.recursive = true; };
      options = {
        silent = true;
        desc = "Toggle split and join code block (recursively)";
      };
    }
  ];
}

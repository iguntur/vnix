{ vnix, ... }:
let
  inherit (vnix.lua) fnRaw mkRequire;
  setup = a: b: fnRaw (mkRequire a b);
in
{
  plugins = {
    flash = {
      enable = true;
    };
  };

  keymaps = [
    {
      mode = "c";
      key = "<c-s>";
      action = setup "flash" "toggle";
      options = {
        silent = true;
        desc = "Toggle Flash Search";
      };
    }
    {
      mode = "o";
      key = "r";
      action = setup "flash" "remote";
      options = {
        silent = true;
        desc = "Flash Remote";
      };
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "R";
      action = setup "flash" "treesitter_search";
      options = {
        silent = true;
        desc = "Flash Treesitter Search";
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action = setup "flash" "treesitter";
      options = {
        silent = true;
        desc = "Flash Treesitter";
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = setup "flash" "jump";
      options = {
        silent = true;
        desc = "Flash";
      };
    }
  ];
}

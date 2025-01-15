{ luaRaw, ... }:
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
      action = luaRaw.keymapRequire "flash" "toggle";
      options = {
        silent = true;
        desc = "Toggle Flash Search";
      };
    }
    {
      mode = "o";
      key = "r";
      action = luaRaw.keymapRequire "flash" "remote";
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
      action = luaRaw.keymapRequire "flash" "treesitter_search";
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
      action = luaRaw.keymapRequire "flash" "treesitter";
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
      action = luaRaw.keymapRequire "flash" "jump";
      options = {
        silent = true;
        desc = "Flash";
      };
    }
  ];
}

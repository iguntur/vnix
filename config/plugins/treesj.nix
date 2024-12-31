{
  config,
  lib,
  luaRaw,
  pkgs,
  ...
}:
{
  plugins = {
    # join and split text line
    treesj = {
      enable = true;
      settings = {
        use_default_keymaps = false;
        max_join_length = 180;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = luaRaw.keymapRequire "treesj" "toggle";
      options = {
        silent = true;
        desc = "Split and join code block";
      };
    }
    {
      mode = "n";
      key = "<leader>M";
      action = luaRaw.keymapRequire' "treesj" "toggle" { split.recursive = true; };
      options = {
        silent = true;
        desc = "Split and join code block recursively";
      };
    }
  ];
}

{ pkgs, vnix, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "move";
      src = pkgs.fetchFromGitHub {
        owner = "fedepujol";
        repo = "move.nvim";
        rev = "cccbd4ea9049ca5f99f025ffaddb7392359c7d6a";
        hash = "sha256-aJi7r9yPdQyH6i8EtQzKdRhEQ3SLz32oqcN0tf2qRZA=";
      };
    })
  ];

  extraConfigLua = vnix.lua.mkRequire' "move" "setup" {
    line = {
      enable = false; # Enables line movement
      indent = false; # Toggles indentation
    };
    block = {
      enable = false; # Enables block movement
      indent = false; # Toggles indentation
    };
    word = {
      enable = true; # Enables word movement
    };
    char = {
      enable = true; # Enables char movement
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<M-l>";
      action = "<cmd>MoveHChar(1)<cr>";
      options.silent = true;
      options.desc = "Move Char to The Right";
    }
    {
      mode = "n";
      key = "<M-h>";
      action = "<cmd>MoveHChar(-1)<cr>";
      options.silent = true;
      options.desc = "Move Char to The Left";
    }

    {
      mode = "n";
      key = "<localleader>w[";
      action = "<cmd>MoveWord(-1)<cr>";
      options.silent = true;
      options.desc = "Move Word to The Left";
    }
    {
      mode = "n";
      key = "<localleader>w]";
      action = "<cmd>MoveWord(1)<cr>";
      options.silent = true;
      options.desc = "Move Word to The Right";
    }
  ];
}

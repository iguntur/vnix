{
  config,
  lib,
  luaRaw,
  pkgs,
  ...
}:
{
  plugins = {
    persistence = {
      enable = true;
      settings = { };
    };
  };

  keymaps =
    let
      persistence = luaRaw.keymapRequire "persistence";
      persistence' = luaRaw.keymapRequire' "persistence";
    in
    [
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options = {
          silent = true;
          desc = "Quit";
        };
      }
      {
        mode = "n";
        key = "<leader>qL";
        action = persistence "load";
        options = {
          silent = true;
          desc = "Load session";
        };
      }
      {
        mode = "n";
        key = "<leader>qS";
        action = persistence "select";
        options = {
          silent = true;
          desc = "Select session";
        };
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = persistence' "load" { last = true; };
        options = {
          silent = true;
          desc = "Restore last session";
        };
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = persistence "stop";
        options = {
          silent = true;
          desc = "Quit without save current session";
        };
      }
    ];
}

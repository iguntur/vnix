{ lib, pkgs, vnix, ... }:
let
  inherit (vnix.lua) fnRaw mkRequire mkRequire';
  setup = a: b: fnRaw (mkRequire a b);
  setup' = a: b: c: fnRaw (mkRequire' a b c);
in
{
  plugins = {
    persistence = {
      enable = true;
      settings = { };
    };
  };

  keymaps =
    let
      persistence = setup "persistence";
      persistence' = setup' "persistence";
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
        key = "<leader>qs";
        action = persistence "load";
        options = {
          silent = true;
          desc = "Load the session for the current directory";
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
        key = "<leader>qL";
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
